export TOR_DIR=$HOME/code/chutney/tor-proxy/tor
export TOR_LOG="stdout"
export TORRC_CUSTOM="$HOME/code/chutney/tor-proxy/torrc"

# $HOME/code/chutney/tor-proxy/tor

# https://hub.docker.com/r/peterdavehello/tor-socks-proxy/
docker run -d --restart=always --name tor-socks-proxy -p 0.0.0.0:9150:9150/tcp -p 8853/udp peterdavehello/tor-socks-proxy:latest

# /usr/bin $ cat /etc/tor/torrc
# HardwareAccel 1
# Log notice stdout
# DNSPort 0.0.0.0:8853
# SocksPort 0.0.0.0:9150
# DataDirectory /var/lib/tor

curl --proxy socks5h://127.0.0.1:9150 https://ipinfo.tw/ip

# Auth cookie
openssl rand -hex 32 | sudo tee $HOME/code/chutney/tor-proxy/authcookie
