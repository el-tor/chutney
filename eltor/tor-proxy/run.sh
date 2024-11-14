mkdir ~/eltor/chutney
mkdir ~/eltor/chutney/tor-proxy
mkdir ~/eltor/chutney/tor-proxy/tor
mkdir ~/eltor/chutney/tor-proxy/eltor
./tor -f torrc-tor-proxy &
./eltor -f torrc-eltor-proxy &
haproxy -f haproxy.cfg
"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --user-data-dir="$HOME/proxy-profile"  --proxy-server="socks5://127.0.0.1:1080"