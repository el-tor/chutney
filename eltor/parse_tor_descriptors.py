import os
from stem.descriptor import parse_file

# Path to the cached consensus file in your Chutney setup
# Update this path to where your Chutney data directory is located
home_directory = os.path.expanduser("~")
consensus_path = home_directory + '/code/chutney/net/nodes/008m/cached-consensus'

# Check if the file exists
if not os.path.exists(consensus_path):
    print(f"Consensus file at {consensus_path} does not exist.")
else:
    # Parse the cached consensus document
    with open(consensus_path, 'rb') as consensus_file:
        for router in parse_file(consensus_file, 'network-status-consensus-3 1.0'):
            print(f"Nickname: {router.nickname}")
            print(f"Address: {router.address}")
            print(f"ORPort: {router.or_port}")
            print(f"DirPort: {router.dir_port}")
            # Determine relay type based on flags
            if 'Authority' in router.flags:
                print("Type: Authority")
            if 'Exit' in router.flags and 'BadExit' not in router.flags:
                print("Type: Exit")
            if 'Guard' in router.flags:
                print("Type: Guard")
            if 'Fast' in router.flags and 'Stable' in router.flags and 'Guard' not in router.flags and 'Exit' not in router.flags:
                print("Type: Middle")
            print("-" * 70)