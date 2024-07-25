export TOR_CMD1="EXTENDCIRCUIT 0 280FCC76D052654361237F95A068F0C618353EF5,B2853E928BF1DA921AF51605BE5D027E04CB6F73,27CC0CFC1CBAA0D84AFB4C6FEFB416C0D609D1FF"
export COOKIE1=$(hexdump -ve '1/1 "%02x"' $HOME/code/chutney/net/nodes/005c/control_auth_cookie)
(
  printf "AUTHENTICATE %s\r\n" "$COOKIE1"
  printf "%s\r\n" "$TOR_CMD1"
  printf "QUIT\r\n"
  sleep 1
) | nc 127.0.0.1 8060