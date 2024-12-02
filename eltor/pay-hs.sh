#!/bin/bash

# Config
COOKIE=$(hexdump -ve '1/1 "%02x"' ~/Library/Application\ Support/TorBrowser-Data/Tor/control_auth_cookie)
PORT=9051
ONION_ADDRESS="fdth5djkloloo52srbi7hvsy3z7hsb7g62ce66inu6wjkg6xfmiej6id.onion"

send_command() {
    local command="$1"
    (echo "AUTHENTICATE $COOKIE"; echo "$command"; echo "QUIT") | nc 127.0.0.1 $PORT
}

build_hs_dir_circuit() {
    echo "Building HSDir circuit..."
    RESPONSE=$(send_command "EXTENDCIRCUIT 0 purpose:HS_CLIENT_HSDIR")
    echo $RESPONSE
    DIR_CIRCUIT_ID=$(echo "$RESPONSE" | grep "EXTENDED" | cut -d' ' -f2)
    echo "HSDir circuit ID: $DIR_CIRCUIT_ID"
}

fetch_descriptor() {
    echo "Fetching HS descriptor..."
    RESPONSE=$(send_command "HSFETCH $ONION_ADDRESS")
    if ! echo "$RESPONSE" | grep -q "250 OK"; then
        echo "Failed to fetch descriptor"
        exit 1
    fi
}

build_rendezvous_circuit() {
    echo "Building rendezvous circuit..."
    RESPONSE=$(send_command "EXTENDCIRCUIT 0 purpose:HS_CLIENT_REND")
    REND_CIRCUIT_ID=$(echo "$RESPONSE" | grep "EXTENDED" | cut -d' ' -f2)
    echo "Rendezvous circuit ID: $REND_CIRCUIT_ID"
    
    send_command "SETCIRCUITPURPOSE $REND_CIRCUIT_ID HS_CLIENT_REND"
}

connect_hidden_service() {
    echo "Connecting to hidden service..."
    RESPONSE=$(send_command "HSPOST $ONION_ADDRESS $REND_CIRCUIT_ID")
    if ! echo "$RESPONSE" | grep -q "250 OK"; then
        echo "Failed to connect to hidden service"
        exit 1
    fi
}

main() {
    build_hs_dir_circuit
    fetch_descriptor
    #build_rendezvous_circuit
    #connect_hidden_service
    #echo "Connected to hidden service"
}

main