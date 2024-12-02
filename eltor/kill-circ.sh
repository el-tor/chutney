
# COOKIE=$(hexdump -ve '1/1 "%02x"' $HOME/code/chutney/net/nodes/005c/control_auth_cookie)
# PORT=8060
COOKIE=$(hexdump -ve '1/1 "%02x"' ~/Library/Application\ Support/TorBrowser-Data/Tor/control_auth_cookie)
PORT=9051

# Connect and authenticate to Tor control port
printf "AUTHENTICATE $COOKIE\r\nGETINFO circuit-status\r\n" | nc 127.0.0.1 $PORT | while read -r line; do
  if [[ $line =~ ^[0-9]+ ]]; then
    circid=$(echo $line | cut -d' ' -f1)
    printf "AUTHENTICATE $COOKIE\r\nCLOSECIRCUIT $circid\r\n" | nc 127.0.0.1 $PORT
  fi
done