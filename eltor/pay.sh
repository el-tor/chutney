#!/bin/bash

## Pass in COOKIE and PORT as environment variables
#COOKIE=$(hexdump -ve '1/1 "%02x"' $HOME/code/chutney/net/nodes/005c/control_auth_cookie)
#PORT=8060
#COOKIE=$(hexdump -ve '1/1 "%02x"' ~/Library/Application\ Support/TorBrowser-Data/Tor/control_auth_cookie)
#PORT=9051
#COOKIE=$(hexdump -ve '1/1 "%02x"' $HOME/code/chutney/eltor/tor-proxy/eltor-data/control_auth_cookie)
#PORT=9097

send_command() {
  local command="$1"
  (echo "AUTHENTICATE $COOKIE"; echo "$command"; echo "QUIT") | nc 127.0.0.1 $PORT
}

# 2. Pay the relays you want to use in this format
# EXTENDPAIDCIRCUIT 0
# fingerprint_entry_guard handshake_fee_payment_hash handshake_fee_preimage 10_payment_ids_concatinated
# fingerprint_middle_relay handshake_fee_payment_hash handshake_fee_preimage 10_payment_ids_concatinated
# fingerprint_exit_relay handshake_fee_payment_hash handshake_fee_preimage 10_payment_ids_concatinated
pay() {
  RESPONSE=$(send_command "+EXTENDPAIDCIRCUIT 0
A7649D89B48EEE5FB1C4583C73F8DA6888A19C12 0c38df961d9721a2faf39324c44e575c1dbf7491250d0507316028b8f4315ff011cc244c4e4e2b1d270f60f8cc47e86fedf3503323ad577999b7ab2e993a57e121cc244c4e4e2b1d270f60f8cc47e86fedf3503323ad577999b7ab2e993a57e231cc244c4e4e2b1d270f60f8cc47e86fedf3503323ad577999b7ab2e993a57e341cc244c4e4e2b1d270f60f8cc47e86fedf3503323ad577999b7ab2e993a57e451cc244c4e4e2b1d270f60f8cc47e86fedf3503323ad577999b7ab2e993a57e561cc244c4e4e2b1d270f60f8cc47e86fedf3503323ad577999b7ab2e993a57e671cc244c4e4e2b1d270f60f8cc47e86fedf3503323ad577999b7ab2e993a57e781cc244c4e4e2b1d270f60f8cc47e86fedf3503323ad577999b7ab2e993a57e891cc244c4e4e2b1d270f60f8cc47e86fedf3503323ad577999b7ab2e993a57e9
52A4FEA9DF61CEBA58C8BF5F1F651A732EFEAB14 0c38df961d9721a2faf39324c44e575c1dbf7491250d0507316028b8f4315ff011cc244c4e4e2b1d270f60f8cc47e86fedf3503323ad577999b7ab2e993a57e121cc244c4e4e2b1d270f60f8cc47e86fedf3503323ad577999b7ab2e993a57e231cc244c4e4e2b1d270f60f8cc47e86fedf3503323ad577999b7ab2e993a57e341cc244c4e4e2b1d270f60f8cc47e86fedf3503323ad577999b7ab2e993a57e451cc244c4e4e2b1d270f60f8cc47e86fedf3503323ad577999b7ab2e993a57e561cc244c4e4e2b1d270f60f8cc47e86fedf3503323ad577999b7ab2e993a57e671cc244c4e4e2b1d270f60f8cc47e86fedf3503323ad577999b7ab2e993a57e781cc244c4e4e2b1d270f60f8cc47e86fedf3503323ad577999b7ab2e993a57e891cc244c4e4e2b1d270f60f8cc47e86fedf3503323ad577999b7ab2e993a57e9
96DC9F9FAB13614AF6D4451B87BEB9546A9EB8A3 0c38df961d9721a2faf39324c44e575c1dbf7491250d0507316028b8f4315ff011cc244c4e4e2b1d270f60f8cc47e86fedf3503323ad577999b7ab2e993a57e121cc244c4e4e2b1d270f60f8cc47e86fedf3503323ad577999b7ab2e993a57e231cc244c4e4e2b1d270f60f8cc47e86fedf3503323ad577999b7ab2e993a57e341cc244c4e4e2b1d270f60f8cc47e86fedf3503323ad577999b7ab2e993a57e451cc244c4e4e2b1d270f60f8cc47e86fedf3503323ad577999b7ab2e993a57e561cc244c4e4e2b1d270f60f8cc47e86fedf3503323ad577999b7ab2e993a57e671cc244c4e4e2b1d270f60f8cc47e86fedf3503323ad577999b7ab2e993a57e781cc244c4e4e2b1d270f60f8cc47e86fedf3503323ad577999b7ab2e993a57e891cc244c4e4e2b1d270f60f8cc47e86fedf3503323ad577999b7ab2e993a57e9
.")
  echo "$RESPONSE"
}
pay2() {
  RESPONSE=$(send_command "+EXTENDPAIDCIRCUIT 0
96DC9F9FAB13614AF6D4451B87BEB9546A9EB8A3 16ea179e9332918b90124b60ecd9b1fe3e08b9e997a058f188ed20cea34a5e0e
52A4FEA9DF61CEBA58C8BF5F1F651A732EFEAB14 16ea179e9332918b90124b60ecd9b1fe3e08b9e997a058f188ed20cea34a5e0e
A7649D89B48EEE5FB1C4583C73F8DA6888A19C12 16ea179e9332918b90124b60ecd9b1fe3e08b9e997a058f188ed20cea34a5e0e
.")
  echo "$RESPONSE"
}
pay3() {
  RESPONSE=$(send_command "+EXTENDPAIDCIRCUIT 0
A7649D89B48EEE5FB1C4583C73F8DA6888A19C12 16ea179e9332918b90124b60ecd9b1fe3e08b9e997a058f188ed20cea34a5e0e
52A4FEA9DF61CEBA58C8BF5F1F651A732EFEAB14 16ea179e9332918b90124b60ecd9b1fe3e08b9e997a058f188ed20cea34a5e0e
96DC9F9FAB13614AF6D4451B87BEB9546A9EB8A3 16ea179e9332918b90124b60ecd9b1fe3e08b9e997a058f188ed20cea34a5e0e
.")
  echo "$RESPONSE"
}

old() {
  RESPONSE=$(send_command "EXTENDCIRCUIT 0 A7649D89B48EEE5FB1C4583C73F8DA6888A19C12,52A4FEA9DF61CEBA58C8BF5F1F651A732EFEAB14,96DC9F9FAB13614AF6D4451B87BEB9546A9EB8A3")
  echo "$RESPONSE"
}

pay
#pay2
#pay3
#old
