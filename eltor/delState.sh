cd "$HOME/Library/Application Support/TorBrowser-Data/Tor"
rm state
rm cached-microdesc-consensus
rm cached-microdescs
rm cached-microdescs.new
rm cached-certs 
rm lock

BASE_DIR="$HOME/code/chutney/net/nodes"

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

# Loop through each subdirectory and delete the specified files
for dir in "$BASE_DIR"/*; do
    if [ -d "$dir" ]; then
        for file in "${FILES_TO_DELETE[@]}"; do
            find "$dir" -type f -name "$file" -exec rm -f {} +
        done
    fi
done

# Find and delete the diff-cache folder
find "$BASE_DIR" -type d -name "diff-cache" -exec rm -rf {} +

echo "All cache, consensus files, and the diff-cache folder have been deleted from $BASE_DIR and its subfolders. and $HOME/Library/Application Support/TorBrowser-Data/Tor"