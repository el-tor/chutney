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

# Start with appropriate config
cd eltor/tor-proxy
if [ "$PROD_MODE" = true ]; then
    ./run.sh --prod
else 
    ./run.sh
fi

# OLD
# $HOME/code/eltor/src/app/tor -f $HOME/code/chutney/eltor/tor-proxy-torrc