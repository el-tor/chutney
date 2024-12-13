import io
import time
import os
import pycurl
import stem.control
import io
import pycurl
import stem.process

from stem.util import term

SOCKS_PORT = 7000
CONNECTION_TIMEOUT = 30

# Static exit for us to make 2-hop circuits through. Picking aurora, a
# particularly beefy one...
#
#   https://metrics.torproject.org/rs.html#details/F6E694C87BB0B7AC2800520444BD3FCE5A3A5729
EXIT_FINGERPRINT = '9928E342EF92F2411D8D68ADC18F6D2B5367171D'

def query(url):
  """
  Uses pycurl to fetch a site using the proxy on the SOCKS_PORT.
  """
  output = io.BytesIO()
  query = pycurl.Curl()
  query.setopt(pycurl.URL, url)
  query.setopt(pycurl.PROXY, 'localhost')
  query.setopt(pycurl.PROXYPORT, SOCKS_PORT)
  query.setopt(pycurl.PROXYTYPE, pycurl.PROXYTYPE_SOCKS5_HOSTNAME)
  query.setopt(pycurl.WRITEFUNCTION, output.write)
  try:
    query.perform()
    status_code = query.getinfo(pycurl.RESPONSE_CODE)
    return status_code, output.getvalue()
  except pycurl.error as exc:
    return "Unable to reach %s (%s)" % (url, exc)

def scan(controller, path):
  """
  Fetch check.torproject.org through the given path of relays, providing back
  the time it took.
  """
  circuit_id = controller.new_circuit(path, await_build = True)
  def attach_stream(stream):
    if stream.status == 'NEW':
      controller.attach_stream(stream.id, circuit_id)
  controller.add_event_listener(attach_stream, stem.control.EventType.STREAM)
  try:
    controller.set_conf('__LeaveStreamsUnattached', '1')  # leave stream management to us
    start_time = time.time()
    status_code, check_page = query('https://check.torproject.org/')
    if status_code != 200:
      raise ValueError("Bad Request")
    elapsed_time = time.time() - start_time
    return elapsed_time
  finally:
    controller.remove_event_listener(attach_stream)
    controller.reset_conf('__LeaveStreamsUnattached')

# Loop circuits and print out how long each takes to fetch check.torproject.org
with stem.control.Controller.from_port(port=7001) as controller:
  controller.authenticate('~/.tor/control_auth_cookie')
  relay_fingerprints = [desc.fingerprint for desc in controller.get_network_statuses()]
  for fingerprint in relay_fingerprints:
    try:
      time_taken = scan(controller, [fingerprint, EXIT_FINGERPRINT])
      print('%s => %0.2f seconds' % (fingerprint, time_taken))
    except Exception as exc:
      print('%s => %s' % (fingerprint, exc))