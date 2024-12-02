#!/bin/bash

# Parse arguments
PROD_MODE=false
for arg in "$@"
do
    case $arg in
        --prod)
        PROD_MODE=true
        shift
        ;;
    esac
done

# Kill existing processes
pkill -f eltor
pkill -f haproxy

mkdir eltor-data
mkdir eltor-data-prod
mkdir tor-data

./tor -f torrc-tor-proxy &

# Start with appropriate config
if [ "$PROD_MODE" = true ]; then
    ./eltor -f torrc-eltor-proxy &
else 
    ./eltor -f torrc-eltor-proxy-chutney &
fi

haproxy -f haproxy.cfg &

"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --proxy-server="socks5://127.0.0.1:1080" &
