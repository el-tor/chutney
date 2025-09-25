#!/bin/bash

# COOKIE=$(hexdump -ve '1/1 "%02x"' $HOME/code/chutney/net/nodes/002a/control_auth_cookie)
# PORT=8057

# COOKIE=$(hexdump -ve '1/1 "%02x"' $HOME/code/chutney/net/nodes/003a/control_auth_cookie)
# PORT=8058

# COOKIE=$(hexdump -ve '1/1 "%02x"' $HOME/code/chutney/net/nodes/000a/control_auth_cookie)
# PORT=8055


# # eltord test 
# {
#   echo 'AUTHENTICATE "password1234_"'
#   echo "SETEVENTS PAYMENT_ID_HASH_RECEIVED"
#   tail -f /dev/null  # Keeps the connection open
# } | nc 127.0.0.1 7781

# {
#   echo 'AUTHENTICATE "password1234_"'
#   echo "TEARDOWNCIRCUIT 3263665762"
#   tail -f /dev/null  # Keeps the connection open
# } | nc 127.0.0.1 7781
## 250 OK SPEC-COMPLIANT TEARDOWN: DESTROY cells sent for circuit 3263665762


# Persistent connection with tail
{
  echo "AUTHENTICATE $COOKIE"
  # P_CircuitID=3263665762
  echo 'TEARDOWNCIRCUIT 3263665762'
  # echo 'CLOSECIRCUIT 12'
  echo 'LOGALLCIRCUITS'
  tail -f /dev/null  # Keeps the connection open
} | nc 127.0.0.1 $PORT

# {
#   echo 'AUTHENTICATE "password1234_"'
#   echo 'LOGALLCIRCUITS'
#   tail -f /dev/null  # Keeps the connection open
# } | nc 127.0.0.1 7781
