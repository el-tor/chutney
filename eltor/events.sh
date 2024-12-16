#!/bin/bash

COOKIE=$(hexdump -ve '1/1 "%02x"' $HOME/code/chutney/net/nodes/000a/control_auth_cookie)
PORT=8055

# Persistent connection with tail
{
  echo "AUTHENTICATE $COOKIE"
  echo "SETEVENTS PAYMENT_ID_HASH_RECEIVED"
  tail -f /dev/null  # Keeps the connection open
} | nc 127.0.0.1 $PORT