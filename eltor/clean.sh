echo "Cleaning Tor Browser"
cd "$HOME/Library/Application Support/TorBrowser-Data/Tor"
rm state
rm cached-microdesc-consensus
rm cached-microdescs.new
rm cached-certs
rm lock