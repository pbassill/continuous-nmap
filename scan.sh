#!/bin/bash

# MODE = T0, T1, T2, T3 etc

MODE="$2"
ADDRESS="$3"
PORTS="$4"
OUTPUT="$5"

COMMONP="5,21,22,23,25,53,80,81,110,111,135,139,143,389,443,445,465,500,587,990,993,995,1433,1521,1723,3306,3389,5000,5432,5900,6379,8080,8081,8443,8888,9001,9030,9100,11211,27017,50000"

if ($PORTS = "x") ; then
 PORTS = $COMMONP
fi

update() {
 git clone https://github.com/vulnersCom/nmap-vulners /usr/share/nmap/scripts/vulners && nmap --script-updatedb
}

scan() {
 nmap -$MODE -sV -Pn -iL $ADDRESS --script=vulners/vulners.nse -p$PORTS -oX $OUTPUT/$(date "+%Y.%m.%d-%H.%M").xml
}

help() {
 echo "Nmap scan script"
 echo "  -h : displays this help"
 echo "  -s : runs a scan"
 echo "  -u : updates the plugin"
 echo ""
 echo "scan.sh requires 4 arguments after the -s. These are:"
 echo "  The speed nmap will run at"
 echo "  The file name and path of the file containing the list of hosts to scan"
 echo "  The ports to scan"
 echo "  The folder where the results should be stored"
 echo ""
 echo "Examples"
 echo ""
 echo "Paranoid scan: scan.sh -s T0 ./live-hosts.txt 1-10000 ./output/"
 echo ""
}

case "$1" in
 help|-h)
  help
  ;;
 scan|-s)
  scan
  ;;
 update|-u)
  update
  ;;
*)
 help
 exit 3
 ;;
 
esac

exit 0
