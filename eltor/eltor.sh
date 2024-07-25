# Config

COOKIE=$(hexdump -ve '1/1 "%02x"' $HOME/code/chutney/net/nodes/005c/control_auth_cookie)
send_command() {
  local command="$1"
  (echo "AUTHENTICATE $COOKIE"; echo "$command"; echo "QUIT") | nc 127.0.0.1 8060
}

# 1. Find the relays
query_relays() {
# Query the available relays
RESPONSE=$(send_command "GETINFO ns/fingerprint")

# Extract relay nicknames and base64 public keys
RELAYS=$(echo "$RESPONSE" | grep '^r ' | awk '{print $2, $3}')

# Convert relays to an array
RELAYS_ARRAY=($RELAYS)

# Get the number of relays
NUM_RELAYS=${#RELAYS_ARRAY[@]}

# Check if there are at least 3 relays
if [ "$NUM_RELAYS" -lt 6 ]; then
  echo "Not enough relays available."
  exit 1
fi

# Generate random indices using awk, sort, and head
RANDOM_INDICES=$(awk -v n="$NUM_RELAYS" 'BEGIN{srand(); for (i=0; i<n; i+=2) print i, rand()}' | sort -k2,2n | head -n 3 | awk '{print $1}')

# Function to get relay fingerprint
get_fingerprint() {
  local pubkey="$1"
  echo "$pubkey" | base64 -d | openssl sha1 | awk '{print toupper($2)}'
}

# Print the selected relay nicknames and fingerprints
echo "Selected relay nicknames and fingerprints:"
for i in $RANDOM_INDICES; do
  NICKNAME="${RELAYS_ARRAY[$i]}"
  PUBKEY="${RELAYS_ARRAY[$((i + 1))]}"
  FINGERPRINT=$(get_fingerprint "$PUBKEY")
  echo "Nickname: $NICKNAME, Fingerprint: $FINGERPRINT"
done

}
query_relays

# 2. Pay the relays you want to use

# 3. Add preimages/pr to the torrc file

# 4. Open Tor browser and connect 


# Check the logs to see if payment went thru

