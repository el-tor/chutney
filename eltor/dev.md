Chutney Testnet bootstrapping
=============================

```sh
## 1. Install python
curl https://pyenv.run | bash
# Then add the following to your ~/.bashrc or ~/.profile:
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
# Restart your shell or run:
source ~/.bashrc
# Install Python 3.8.10 with pyenv
pyenv install 3.8.10
pyenv local 3.8.10

## 2. Config the public IP address
# in eltor/start.sh add this IP address setting
CHUTNEY_LISTEN_ADDRESS=X.X.X.X

## 3. Allow Firewall ports
eltor/fw.sh

## 4. Configure the network
export TOR_DIR=$HOME/code/eltor/src/app/tor
export CHUTNEY_TOR=$HOME/code/eltor/src/app/tor
export CHUTNEY_TOR_GENCERT=$HOME/code/eltor/src/tools/tor-gencert
export CHUTNEY_DEBUG=true
export TOR_LOG="debug stdout"
export TORRC_CUSTOM="/Applications/Tor Browser.app/Contents/Resources/TorBrowser/Tor/torrc"
./chutney configure networks/basic-min

## 5. Start Chutney
eltor/start.sh
```