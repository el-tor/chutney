${include:common.i}
SocksPort 0
Address $ip

HiddenServiceDir ${dir}/hidden_service/hostname

# Redirect requests to the port used by chutney verify
HiddenServicePort 80 127.0.0.1:4747
