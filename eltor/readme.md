# El Tor Chutney Testnet

Quickstart
========================================================================================================================
1. Make sure the eltor tor drop in replacement binary is copied to these locations
```
$HOME/code/eltor/src/app/tor
/Applications/Tor Browser.app/Contents/MacOS/Tor/tor
```
You might want to run a command like this to copy from the eltor repo (after you run make):
`cp $HOME/code/eltor/src/app/tor "/Applications/Tor Browser.app/Contents/MacOS/Tor/tor"`
2. navigate to the chutney directory `cd ../`
** *these scripts were tested on a mac (you might need to tweak for your OS)*
3.  Set the environment variable to use your local Tor binary. create an env.sh script in eltor/env.sh
```
touch eltor/env.sh
```
add the following to your env files with your file locations
```
export TOR_DIR=$HOME/code/eltor/src/app/tor
export CHUTNEY_TOR=$HOME/code/eltor/src/app/tor
export CHUTNEY_TOR_GENCERT=$HOME/code/eltor/src/tools/tor-gencert
export CHUTNEY_DEBUG=true
export TOR_LOG="debug stdout"
# export TORRC_CUSTOM="/Applications/Tor Browser.app/Contents/Resources/TorBrowser/Tor/torrc"
```
4. in the chutney (root) directory run `. eltor/env.sh`
5. You might need to turn off your firewall or allow the relays thru 
6. Configure you local network card to allow the relays to have unique loopback addresses.
on mac (run `nic.sh` and `fw.sh`) for ip range 127.0.0.10-127.0.0.18
```
sudo ifconfig lo0 alias 127.0.0.10 netmask 0xff000000
```
7. If this is your first running chutney bootstrap the network `./chutney configure networks/basic-min`
8. Now set the torrc config for the Tor Browser to use chutney config
```
code ~/Library/Application\ Support/TorBrowser-Data/Tor/torrc
```
check out the `tor-chutney-sample-torrc` file in this directory. Make sure to replace $HOME (YOUR_HOME_DIR) with your home directory i.e /Users/yourname
9. then run `eltor/start.sh`
10. after you are done run `eltor/stop.sh`
11. You can run `eltor/restart.sh` to restart the tor chutney testnet and clear debug logs
12. This should open the tor browser. 
13. Make sure you have valid preimage and payhash configs in the torrc config here `cat ~/Library/Application\ Support/TorBrowser-Data/Tor/torrc`

Scripts
========================================================================================================================
To run a proxy
```
eltor/delState.sh
eltor/proxy.sh
eltor/proxy-stop.sh
```

To pay for a circuit 
(005c hidden service, tor browser, chrome)
```
eltor/pay-all.sh
```

Nyx 
``` 
nyx -i 127.0.0.1:8060 # hidden service 005c
nyx -i 127.0.0.1:9051 # tor browser
nyx -i 127.0.0.1:9097 # chrome browser with socks proxy
```

Running a relay
========================================================================================================================
See `tor-relay-sample-torrc` sample config file. 
Make sure to configure your Address (IP), Nickname, OrPort and set `AssumeReachable 1`. 

You might need to allow the OrPort port thru your firewall or UPNP via https://github.com/Yawning/tor-fw-helper). 

Run this command on the computer you want to become a El Tor Relay:
```
tor -f /path/to/torrc
```
El Tor TestNet `Directory Authority` Config
```
DirAuthority test000a orport=5055 no-v2 v3ident=08E3B412A2F9B7BE30CAC56285EB0A31AD23FD86 93.127.216.111:7055 F9EEDC6ECCC301A1B59122651658AD2476ED3CA1
DirAuthority test001a orport=5056 no-v2 v3ident=9BECD814BFB4F078FBBEB56D5E51F34A0D364B3A 93.127.216.111:7056 66B7E5A12A585D41256F866B5CC97ACE15CA7AC2
DirAuthority test002a orport=5057 no-v2 v3ident=D7AA5EEEA0288AD6F58302CF0FCE477D7B59E85A 93.127.216.111:7057 371E875605E2ADE3B2AEA2C4FF20F0F197D0AFDF
DirAuthority test003a orport=5058 no-v2 v3ident=B8672FFE32B1BE2A2EFE3534B7A75A27F6804503 93.127.216.111:7058 0FC4EB502F5B7A9A7911017248BAFD06C0026E7E
```

# Directory Authority
http://127.0.0.10:7055/tor/status-vote/current/consensus 

### Voting Delays
torrc config on the DAs
```
# Directory Authority Config
V3AuthVotingInterval 30 seconds
V3AuthVoteDelay 5 seconds
V3AuthDistDelay 5 seconds
# Minimum uptime required for a relay to be considered a hidden service directory
MinUptimeHidServDirectoryV2 30 seconds
# Fraction of the bandwidth threshold for voting on the Guard flag
AuthDirVoteGuardBwThresholdFraction 0.01
# Minimum time known for a relay to be considered for the Guard flag
AuthDirVoteGuardGuaranteeTimeKnown 30 seconds 
# Minimum weighted fractional uptime for a relay to be considered for the Guard flag
AuthDirVoteGuardGuaranteeWFU 0.01
```

Fingerprint tool
========================================================================================================================

To get the fingerprint of
```
r plebrelay1 Yn5iNtnpgLLJV15wDalQw3SiVo8 EQ2G56Jg8OBLPBIfZRi5YJCUkMI 2024-10-03 02:00:40 172.81.178.30 5061 0
```
run
```
python eltor/fingerprint-tool.py Yn5iNtnpgLLJV15wDalQw3SiVo8
```

Tor Browser
========================================================================================================================

```
cd "/Applications/Tor Browser.app/Contents/Resources/TorBrowser/Tor"
cd "$HOME/Library/Application Support/TorBrowser-Data"
open "$HOME/Library/Application Support/TorBrowser-Data"
```

To reset the Tor Browser back to default `rm -rf "$HOME/Library/Application Support/TorBrowser-Data"`

**If the Tor browser has issues connecting try clearing the state (especially when switching between mainnet and chutney)
`eltor/delState.sh `

## torrc
```
code ~/Library/Application\ Support/TorBrowser-Data/Tor/torrc
```
check out the `tor-chutney-sample-torrc` file in this directory

debug log 
```
code ~/Library/Application\ Support/TorBrowser-Data/Tor/debug.log
```

### Symobilic Links
(replace nodes.1717275556 with your values below)
```
sudo ln -s $HOME/code/eltor/src/app/tor /Applications/Tor\ Browser.app/Contents/MacOS/Tor/tor

sudo cp $HOME/code/eltor/src/app/tor /Applications/Tor\ Browser.app/Contents/MacOS/Tor/tor

ln -s $HOME/code/chutney/net/nodes.1717275556 $HOME/code/chutney/net/nodes
```


### Hidden Service
```
pyenv local 3.8.10
python3 -m http.server 4747
```


### Networking
```
lsof -i -P | grep -i "listen" | grep tor
sudo ifconfig lo0 alias 127.0.0.10 netmask 0xff000000
```

# debug tor config with tor browser config
```
/Applications/Tor\ Browser.app/Contents/MacOS/Tor/tor -f "/Applications/Tor Browser.app/Contents/Resources/TorBrowser/Tor/torrc"

open /Applications/Tor\ Browser.app
```


Basic Setup
========================================================================================================================
### 1. config the network
./chutney configure networks/basic-min
### 2. enable hidden service config
#### https://www.youtube.com/watch?v=iDvuQJbZw3Y
```
code $HOME/code/chutney/net/nodes/005c/torrc 
SocksPort 9005
Address 127.0.0.1
HiddenServiceDir $HOME/code/chutney/net/nodes.1715551615/005c/hidden_service 
HiddenServiceVersion 3
HiddenServicePort 80 127.0.0.1:4747
```

### 3. Configure Tor Browser
```
code "$HOME/Library/Application Support/TorBrowser-Data/Tor/torrc"
touch "$HOME/Library/Application Support/TorBrowser-Data/Tor/torrc"
```
Go to each torrc file in net folder and configure diff IP addresses 127.0.0.10 etc...
`mkdir ./net/nodes/browser`

Tor Browser torrc
```
# This file was generated by Tor; if you edit it, comments will not be preserved
# The old torrc file was renamed to torrc.orig.1, and Tor will ignore it
AllowNonRFC953Hostnames 1
ClientOnionAuthDir ~/Library/Application Support/TorBrowser-Data/Tor/onion-auth
DataDirectory ~/Library/Application Support/TorBrowser-Data/Tor
DirAuthority test000a orport=5055 no-v2 v3ident=F643C3802E0F8F442FCCED2C3636B295C603F151 127.0.0.10:7055 A5ED069D963EF7283BC3A936263C88D00EB5EBB1
DirAuthority test001a orport=5056 no-v2 v3ident=DDBE832B056ACF4BA3F87A93E42B010EBA1512CA 127.0.0.11:7056 66E35C7A0729351A44AFE8D26081ABE5A784F16D
DirAuthority test002a orport=5057 no-v2 v3ident=329D2444F35C6854BAFF60C60EE954636C0E4C2D 127.0.0.12:7057 F366A7EED8DFAA4C48F0822AA4AE5F703424F07C
DirAuthority test003a orport=5058 no-v2 v3ident=23DA7BA6B6B53576DA205C1520081AFBDEA24032 127.0.0.13:7058 0CA0A465097AC596743904BD39399E9018123A5A
GeoIPFile /Applications/Tor Browser.app/Contents/Resources/TorBrowser/Tor/geoip
GeoIPv6File /Applications/Tor Browser.app/Contents/Resources/TorBrowser/Tor/geoip6
Log notice file ~/code/chutney/net/nodes/browser/notice.log
Log info file ~/code/chutney/net/nodes/browser/info.log
Log debug file ~/code/chutney/net/nodes/browser/debug.log
Nickname torbrowser
PathsNeededToBuildCircuits 0.670000
TestingDirAuthVoteExit *
TestingDirAuthVoteGuard *
TestingDirAuthVoteHSDir *
TestingTorNetwork 1
V3AuthNIntervalsValid 2
ControlPort 9051
CookieAuthentication 1
ElTorPayHashHop1 16ea179e9332918b90124b60ecd9b1fe3e08b9e997a058f188ed20cea34a5e0e
ElTorPayHashHop2 16ea179e9332918b90124b60ecd9b1fe3e08b9e997a058f188ed20cea34a5e0e
ElTorPayHashHop3 16ea179e9332918b90124b60ecd9b1fe3e08b9e997a058f188ed20cea34a5e0e
ElTorPayHashHop4 16ea179e9332918b90124b60ecd9b1fe3e08b9e997a058f188ed20cea34a5e0e
ElTorPayHashHop5 16ea179e9332918b90124b60ecd9b1fe3e08b9e997a058f188ed20cea34a5e0e
ElTorPayHashHop6 16ea179e9332918b90124b60ecd9b1fe3e08b9e997a058f188ed20cea34a5e0e
ElTorPayHashHop7 16ea179e9332918b90124b60ecd9b1fe3e08b9e997a058f188ed20cea34a5e0e
ElTorPreimageHop1 68b4e782fafbd5a057ec4c277f01da48db73dd67326ec4458ff89daffba186e3
ElTorPreimageHop2 68b4e782fafbd5a057ec4c277f01da48db73dd67326ec4458ff89daffba186e3
ElTorPreimageHop3 68b4e782fafbd5a057ec4c277f01da48db73dd67326ec4458ff89daffba186e3
ElTorPreimageHop4 68b4e782fafbd5a057ec4c277f01da48db73dd67326ec4458ff89daffba186e3
ElTorPreimageHop5 68b4e782fafbd5a057ec4c277f01da48db73dd67326ec4458ff89daffba186e3
ElTorPreimageHop6 68b4e782fafbd5a057ec4c277f01da48db73dd67326ec4458ff89daffba186e3
ElTorPreimageHop7 68b4e782fafbd5a057ec4c277f01da48db73dd67326ec4458ff89daffba186e3
PaymentBolt12Offer lno334
PaymentRate 1000
```
### 4. start the network
```
./chutney start networks/basic-min
```
### 5. verify the network
```
./chutney status networks/basic-min

python parse_tor_descriptors.py
```
### 6. verify the hidden service
```
curl --proxy socks5h://localhost:9055 http://$(cat $HOME/code/chutney/net/nodes/005c/hidden_service/hostname)
hhvdcwx7ytb6fnd2brn54w6rcpwzmmntczivzfxz6hoagi55ffg5wwad.onion
```
### 7. stop the network
```
./chutney stop networks/basic-min
```
#### 8. Tor browser boot test
```
"/Applications/Tor Browser.app/Contents/MacOS/Tor/tor" -f $HOME/code/chutney/net/nodes.1717275556/005c/torrc
"/Applications/Tor Browser.app/Contents/MacOS/Tor/tor" -f $HOME/code/chutney/net/nodes.1717275556/000a/torrc
```

Monitoring
========================================================================================================================
`nyx -i 127.0.0.1:8055`


# ======Scratch Notes and Misc====== #

#### IPV6
sudo python3 -m http.server 80 --bind 2605:a601:aa51:b300:c32:bd77:acde:76e9
2602:ffb6:4:eff5:f816:3eff:fe19:7a0b

### Spec 
https://spec.torproject.org/tor-spec/create-created-cells.html


### RPC
```
TOR_CMD="GETINFO ns/all"
TOR_CMD="SETCONF ContactInfo={relay1Preimage:abc123}\r\nSAVECONF"
TOR_CMD="EXTENDCIRCUIT 0 280FCC76D052654361237F95A068F0C618353EF5,B2853E928BF1DA921AF51605BE5D027E04CB6F73,27CC0CFC1CBAA0D84AFB4C6FEFB416C0D609D1FF"
COOKIE=$(hexdump -ve '1/1 "%02x"' $HOME/code/chutney/net/nodes/005c/control_auth_cookie)
(echo -e "AUTHENTICATE $COOKIE\r\n$TOR_CMD\r\nQUIT\r\n"; sleep 1) | nc 127.0.0.1 8060 
```

### 000a, 001a, 004r
```
TOR_CMD="EXTENDCIRCUIT 0 280FCC76D052654361237F95A068F0C618353EF5,B2853E928BF1DA921AF51605BE5D027E04CB6F73,27CC0CFC1CBAA0D84AFB4C6FEFB416C0D609D1FF"
```

### Chutney commands
```
./chutney stop networks/basic
./chutney configure networks/basic
./chutney start networks/basic
./chutney verify networks/basic
./chutney stop networks/myexit
./chutney configure networks/myexit
./chutney start networks/myexit
./chutney verify networks/myexit
./chutney stop networks/bridges+hs-v3
./chutney configure networks/bridges+hs-v3
```

### Hidden services 
- Create the hidden service directory if it doesn't already exist
`mkdir -p $HOME/code/chutney/net/nodes/009h/hidden_service`
- Run Tor to generate the hidden service keys
```
$HOME/code/eltor/src/app/tor --runasdaemon 0 --DataDirectory $HOME/code/chutney/net/nodes/009h/hidden_service \
     --HiddenServiceDir $HOME/code/chutney/net/nodes/009h/hidden_service \
     --HiddenServiceVersion 3 \
     --HiddenServicePort "80 127.0.0.1:4747"

./chutney start networks/bridges+hs-v3
./chutney verify networks/bridges+hs-v3
```

### Tor Browser Config
```
about:config

extensions.torlauncher.start_tor : true
network.proxy.socks_host : 127.0.0.1
network.proxy.socks_port : 9006 (9150 default)
```

Troubleshooting
==================
## Python
You might need an older version of python.
```
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt install python3.8
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 2
sudo update-alternatives --config python3
```

You need to use python v3.8.10. Sometimes python3 does not work and points to the wrong version. 
you can check by running
```
pyenv local 3.8.10
python --version
python3 --version
```

If the version mismatches add this code below to your `~/.profile` or `~/.bashrc` or `~/.zshrc`

```
#### To make pyenv work on python and python3
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
##### End of pyenv
```

Tor Browser Troubleshooting:
1. `rm -rf "$HOME/Library/Application Support/TorBrowser-Data"`
2. Then recopy the torrc file over 
3. Then copy eltor binary over `cp $HOME/code/eltor/src/app/tor "/Applications/Tor Browser.app/Contents/MacOS/Tor/tor"`
