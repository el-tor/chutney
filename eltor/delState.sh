#!/bin/bash

# Define base directories
BASE_DIRS=(
    "$HOME/Library/Application Support/TorBrowser-Data/Tor"
    "$HOME/code/chutney/net/nodes/000a"
    "$HOME/code/chutney/net/nodes/001a"
    "$HOME/code/chutney/net/nodes/002a"
    "$HOME/code/chutney/net/nodes/003a"
    "$HOME/code/chutney/net/nodes/004r"
    "$HOME/code/chutney/net/nodes/005c"
    "$HOME/code/chutney/net/nodes/006m"
    "$HOME/code/chutney/net/nodes/007m"
    "$HOME/code/chutney/net/nodes/008m"
    "$HOME/code/chutney/net/nodes/browser"
    "$HOME/code/chutney/eltor/tor-proxy/eltor-data"
    "$HOME/code/chutney/eltor/tor-proxy/eltor-data-prod"
    "$HOME/code/chutney/eltor/tor-proxy/tor-data"
)

# List of files to delete
FILES_TO_DELETE=(
    "cached-consensus"
    "cached-certs"
    "cached-extrainfo"
    "cached-extrainfo.new"
    "cached-consensus.new"
    "cached-descriptors"
    "cached-descriptors.new"
    "cached-microdesc-consensus"
    "cached-microdesc-consensus.new"
    "cached-microdescs"
    "cached-microdescs.new"
    "my-consensus-microdesc"
    "my-consensus-ns"
    "router-stability"
    "state"
    "sr-state"
    "unverified-consensus"
    "v3-status-votes"
)

# Loop through each base directory
for BASE_DIR in "${BASE_DIRS[@]}"; do
    echo "Processing directory: $BASE_DIR"
    
    # Check if directory exists
    if [ ! -d "$BASE_DIR" ]; then
        echo "Directory does not exist: $BASE_DIR"
        continue
    fi
    
    # Delete files
    for file in "${FILES_TO_DELETE[@]}"; do
        find "$BASE_DIR" -type f -name "$file" -exec rm -f {} \;
    done
done

echo "Cleanup complete"