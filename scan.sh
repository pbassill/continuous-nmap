#!/bin/bash

# MODE = T0, T1, T2, T3 etc

MODE="$1"
ADDRESS="$2"
PORTS="$3"
OUTPUT="$4"

COMMONP="5,21,22,23,25,53,80,81,110,111,135,139,143,389,443,445,465,500,587,990,993,995,1433,1521,1723,3306,3389,5000,5432,5900,6379,8080,8081,8443,8888,9001,9030,9100,11211,27017,50000"

if ($PORTS = "x") ; then
 PORTS = $COMMONP

# Install vulners database
git clone https://github.com/vulnersCom/nmap-vulners /usr/share/nmap/scripts/vulners && nmap --script-updatedb

# Run scan
nmap -$MODE -sV -Pn $ADDRESS --script=vulners/vulners.nse -p$PORTS -oX $OUTPUT/$(date "+%Y.%m.%d-%H.%M").xml



