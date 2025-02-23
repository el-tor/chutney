COOKIE=$(hexdump -ve '1/1 "%02x"' $HOME/code/chutney/net/nodes/005c/control_auth_cookie) PORT=8060 eltor/pay.sh

COOKIE=$(hexdump -ve '1/1 "%02x"' ~/Library/Application\ Support/TorBrowser-Data/Tor/control_auth_cookie) PORT=9051 eltor/pay.sh

#COOKIE=$(hexdump -ve '1/1 "%02x"' $HOME/code/chutney/eltor/tor-proxy/eltor-data/control_auth_cookie) PORT=9097 eltor/pay.sh