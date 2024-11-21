#!/bin/bash

# https://www.cvedetails.com/cve/CVE-2017-12172/

cve_2017_12172(){
    echo -e "${YELLOW}[*] Checking CVE-2017-12172...${RESET}"

    local NAME="CVE-2017-12172"
    local DESC="Allows an attacker to escalate its privileges to root"
    local SEVERITY="HIGH"
    local SCORE="7.2"

    VERSION=$(psql -V | awk '{print $3}')

    if { [[ $(echo "$VERSION == 10" | bc) -eq 1  ]] ||
         [[ $(echo "$VERSION == 9.2" | bc) -eq 1  ]] ||
         [[ $(echo "$VERSION >= 9.2" | bc) -eq 1 && $(echo "$VERSION <= 9.2" | bc) -eq 1  ]] ||
         [[ $(echo "$VERSION >= 9.3" | bc) -eq 1 && $(echo "$VERSION <= 9.3" | bc) -eq 1  ]] ||
         [[ $(echo "$VERSION >= 9.4" | bc) -eq 1 && $(echo "$VERSION <= 9.4" | bc) -eq 1 ]]  ||
         [[ $(echo "$VERSION >= 9.2" | bc) -eq 1 && $(echo "$VERSION <= 9.6" | bc) -eq 1 ]]

        }; then

        vulnerabilities+=("$NAME|$DESC|$SEVERITY|$SCORE|1")
        echo -e "${RED}[!] Vulnerable to CVE-2017-12172!${RESET}"
    else
        echo -e "${GREEN}[+] Not vulnerable to CVE-2017-12172.${RESET}"
    fi
}
