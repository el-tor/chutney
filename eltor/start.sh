export TOR_DIR=$HOME/code/tor/src/app/tor
export CHUTNEY_TOR=$HOME/code/tor/src/app/tor
export CHUTNEY_TOR_GENCERT=$HOME/code/tor/src/tools/tor-gencert
export CHUTNEY_DEBUG=true
export TOR_LOG="debug stdout"
export TORRC_CUSTOM="/Applications/Tor Browser.app/Contents/Resources/TorBrowser/Tor/torrc"

eltor/nic.sh
eltor/delState.sh
./chutney start networks/basic-min
./chutney status networks/basic-min