#!/bin/bash

# home.mamacdon.ca
# L3391=192.168.1.3:3389,L5001=localhost:5001,L5080=192.168.1.1:80,L5090=192.168.100.1:80
# The above syntax is from Putty
#
# Local port    Machine                 Protocol
#
# 1139          fenixfunk5 SMB          SMB
# 3391          sublimit port 3389      RDP
# 5001          fenixfunk5 web admin    HTTPS
# 5080          router admin page       HTTP
# 5090          modem diag page         HTTP
ssh_home_mamacdon_ca() {
    ssh mamacdon@home.mamacdon.ca \
        -i $HOME/.ssh/id_rsa \
        -p 2222 \
        -L 6969:localhost:22 \
        -L 1139:localhost:139 \
        -L 3391:192.168.1.3:3389 \
        -L 5001:localhost:5001 \
        -L 5080:192.168.1.1:80 \
        -L 5090:192.168.100.1:80 \
        ''
}

scp_home_mamacdon_ca() {
    scp -i $HOME/.ssh/id_rsa \
        -P 2222 \
        "$@"
}
