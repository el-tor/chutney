cd "$HOME/Library/Application Support/TorBrowser-Data/Tor"
rm state
rm cached-microdesc-consensus
rm cached-microdescs
rm cached-microdescs.new
rm cached-certs 
rm lock

# Define the base directory
BASE_DIR="$HOME/code/chutney/net"

# List of files to delete
FILES_TO_DELETE=(
    "cached-consensus"
    "cached-consensus.new"
    "cached-descriptors"
    "cached-descriptors.new"
    "cached-microdesc-consensus"
    "cached-microdesc-consensus.new"
    "cached-microdescs"
    "cached-microdescs.new"
    "state"
    "sr-state"
    "unverified-consensus"
)

# Find and delete the files
find "$BASE_DIR" -type f \( -name "cached-consensus" \
    -o -name "cached-certs" \
    -o -name "cached-extrainfo" \
    -o -name "cached-extrainfo.new" \
    -o -name "cached-consensus.new" \
    -o -name "cached-descriptors" \
    -o -name "cached-descriptors.new" \
    -o -name "cached-microdesc-consensus" \
    -o -name "cached-microdesc-consensus.new" \
    -o -name "cached-microdescs" \
    -o -name "cached-microdescs.new" \
    -o -name "my-consensus-microdesc" \
    -o -name "my-consensus-ns" \
    -o -name "router-stability" \
    -o -name "state" \
    -o -name "sr-state" \
    -o -name "v3-status-votes" \
    -o -name "unverified-consensus" \) -exec rm -f {} +

# Find and delete the diff-cache folder
find "$BASE_DIR" -type d -name "diff-cache" -exec rm -rf {} +

echo "All cache, consensus files, and the diff-cache folder have been deleted from $BASE_DIR and its subfolders. and $HOME/Library/Application Support/TorBrowser-Data/Tor"