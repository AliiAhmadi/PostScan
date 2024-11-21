#!/bin/bash

# https://www.cvedetails.com/cve/CVE-2017-14798/

cve_2017_14798(){
    echo -e "${YELLOW}[*] Checking CVE-2017-14798...${RESET}"

    local NAME="CVE-2017-14798"
    local DESC="Unwanted access to postgresql account to escalate attacker privileges to root"
    local SEVERITY="HIGH"
    local SCORE="7.3"

    VERSION=$(psql -V | awk '{print $3}')

    if { [[ $(echo "$VERSION <= 9.4" | bc) -eq 1 ]]

        }; then

        vulnerabilities+=("$NAME|$DESC|$SEVERITY|$SCORE|0")
        echo -e "${RED}[!] Vulnerable to CVE-2017-14798!${RESET}"
    else
        echo -e "${GREEN}[+] Not vulnerable to CVE-2017-14798.${RESET}"
    fi
}
