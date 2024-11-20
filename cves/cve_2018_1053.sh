#!/bin/bash

# https://www.cvedetails.com/cve/CVE-2018-1053/

cve_2018_1053(){
    echo -e "${YELLOW}[*] Checking CVE-2018-1053...${RESET}"

    local NAME="CVE-2018-1053"
    local DESC="Allows an authenticated attacker to modify files which may contain database passwords"
    local SEVERITY="HIGH"
    local SCORE="7.0"

    VERSION=$(psql -V | awk '{print $3}')

    if { 
         [[ $(echo "$VERSION == 10.0" | bc) -eq 1  ]] ||
         [[ $(echo "$VERSION == 10.1" | bc) -eq 1  ]] ||
         [[ $(echo "$VERSION >= 9.3.0" | bc) -eq 1 && $(echo "$VERSION < 9.3.21" | bc) -eq 1  ]] ||
         [[ $(echo "$VERSION >= 9.4.0" | bc) -eq 1 && $(echo "$VERSION < 9.4.16" | bc) -eq 1  ]] ||
         [[ $(echo "$VERSION >= 9.5.0" | bc) -eq 1 && $(echo "$VERSION < 9.5.11" | bc) -eq 1  ]] ||
         [[ $(echo "$VERSION >= 9.6.0" | bc) -eq 1 && $(echo "$VERSION < 9.6.7" | bc) -eq 1 ]]

        }; then

        vulnerabilities+=("$NAME|$DESC|$SEVERITY|$SCORE")
        echo -e "${RED}[!] Vulnerable to CVE-2018-1053!${RESET}"
    else
        echo -e "${GREEN}[+] Not vulnerable to CVE-2018-1053.${RESET}"
    fi
}