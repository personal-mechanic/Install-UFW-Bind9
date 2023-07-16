#!/bin/bash

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

echo installing the must-have pre-requisites
while read -r p ; do sudo apt-get install -y $p ; done < <(cat << "EOF"
    ufw
    bind9
    bind9utils
    bind9-doc
    dnsutils
    sudo
EOF
)

echo installing the nice-to-have pre-requisites
echo -e "\n"
sleep 1

sudo ufw allow 22/tcp && sudo ufw allow 53/tcp && sudo ufw allow 53/udp && sudo ufw logging on && sudo ufw logging medium && sudo ufw enable && sudo systemctl enable ufw && sudo systemctl start bind9 && sudo nano /etc/bind/named.conf.options
