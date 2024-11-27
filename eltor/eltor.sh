# Config

COOKIE=$(hexdump -ve '1/1 "%02x"' $HOME/code/chutney/net/nodes/005c/control_auth_cookie)
send_command() {
  local command="$1"
  (echo "AUTHENTICATE $COOKIE"; echo "$command"; echo "QUIT") | nc 127.0.0.1 8060
}

# 0. Get all relay info
getAll() {
  RESPONSE=$(send_command "GETINFO ns/all") 
  echo "$RESPONSE"
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

# 2. Pay the relays you want to use
pay() {
  RESPONSE=$(send_command "+EXTENDPAIDCIRCUIT 0
309C89ABC3E770AA4837EBE92E8666AE71006431 16ea179e9332918b90124b60ecd9b1fe3e08b9e997a058f188ed20cea34a5e0e 68b4e782fafbd5a057ec4c277f01da48db73dd67326ec4458ff89daffba186
309C89ABC3E770AA4837EBE92E8666AE71006432 16ea179e9332918b90124b60ecd9b1fe3e08b9e997a058f188ed20cea34a5e0f 68b4e782fafbd5a057ec4c277f01da48db73dd67326ec4458ff89daffba187
309C89ABC3E770AA4837EBE92E8666AE71006433 16ea179e9332918b90124b60ecd9b1fe3e08b9e997a058f188ed20cea34a5e10 68b4e782fafbd5a057ec4c277f01da48db73dd67326ec4458ff89daffba188
.")
  echo "$RESPONSE"
}

# 3. Add preimages/pr to the torrc file

# 4. Open Tor browser and connect 
# Check the logs to see if payment went thru

# 4. Build non paid circuit

# 5. Get the built circuits
buildCircuit() {
  RESPONSE=$(send_command "EXTENDCIRCUIT 0 A7649D89B48EEE5FB1C4583C73F8DA6888A19C12,52A4FEA9DF61CEBA58C8BF5F1F651A732EFEAB14,96DC9F9FAB13614AF6D4451B87BEB9546A9EB8A3") 
  echo "$RESPONSE"
}

# 6. Get the built circuits
getCircuits() {
  RESPONSE=$(send_command "GETINFO circuit-status") 
  echo "$RESPONSE"
}



# 0. getAll
# getAll

# 1. #query_relays
# query_relays

# 2. pay
# pay

# 3. 
# 4.

# 5. buildCircuit
#buildCircuit

# 6. getCircuits
getCircuits