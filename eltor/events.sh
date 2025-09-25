#!/bin/bash

# COOKIE=$(hexdump -ve '1/1 "%02x"' $HOME/code/chutney/net/nodes/002a/control_auth_cookie)
# PORT=8057

# COOKIE=$(hexdump -ve '1/1 "%02x"' $HOME/code/chutney/net/nodes/003a/control_auth_cookie)
# PORT=8058

# COOKIE=$(hexdump -ve '1/1 "%02x"' $HOME/code/chutney/net/nodes/000a/control_auth_cookie)
# PORT=8055

COOKIE=$(hexdump -ve '1/1 "%02x"' $HOME/code/chutney/net/nodes/008m/control_auth_cookie)
PORT=8063



# # eltord test 
{
  echo 'AUTHENTICATE "password1234_"'
  echo "SETEVENTS PAYMENT_ID_HASH_RECEIVED"
  tail -f /dev/null  # Keeps the connection open
} | nc 127.0.0.1 7781

# Persistent connection with tail
# {
#   echo "AUTHENTICATE $COOKIE"
#   echo "SETEVENTS PAYMENT_ID_HASH_RECEIVED"
#   tail -f /dev/null  # Keeps the connection open
# } | nc 127.0.0.1 $PORT

# RESPONSE
# 650 EVENT_PAYMENT_ID_HASH_RECEIVED P_CIRC_ID=2517280858 N_CIRC_ID=0 PAYMENT_HASH=67263e47beba2926942d7a1dce34298b89519706457d9c3dd620d5288c30539e368bc788528fd8c0486fe33dd841260205cb6356ac68e4eee151877001518f358ef7d67d338446f3083fb92597f224f0509e0b75611fa52b5f57b682bcd96b67f5ddd9ee4ea378788806135c9696d8d5ccd0e7403f6a8d0e2630c352036cf1abaceeb60d9b7a3c477cc05f486031961f4dbf34ab87ec036353b3519a8a1d8f5c13d7e3eb010edbbbe77e2ace3b77ff53c80686bb0f1c1c44e0e213b6d0508a9fad981fca347bd7db42e09b957bffe52984ee7d5e01a8a3afc2b79df6173cb1ee1162d17b70375775340dd1f21c6e271f733156df08dfbb25c759f6cb8785c3a6810fc82aaec4448fc3f750b64dea17d0d988b1dba1678a5489448f16f907112739640eb975e543da7c53d0474d6617e776c51a9ef2b507ac2c3ae548374230f7a6fe7d1cc07c948e5827ba739d64bc803dc2297e02901c8d15e8f5110fb1cc09b3a79d51813c647849ace45c5497daf71c39054059802d02e4e7b1603e9f00b0


# {
#   echo 'AUTHENTICATE "password1234_"'
#   echo "SETEVENTS PAYMENT_ID_HASH_RECEIVED"
#   tail -f /dev/null  # Keeps the connection open
# } | nc 127.0.0.1 7781