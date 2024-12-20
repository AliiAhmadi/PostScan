#!/bin/bash

# https://www.cvedetails.com/cve/CVE-2017-7546/

cve_2017_7546(){
    echo -e "${YELLOW}[*] Checking CVE-2017-7546...${RESET}"

    local NAME="CVE-2017-7546"
    local DESC="Allows remote attackers to gain access to database accounts with an empty password"
    local SEVERITY="CRITICAL"
    local SCORE="9.8"

    VERSION=$(psql -V | awk '{print $3}')

    if { [[ $(echo "$VERSION >= 9.2" | bc) -eq 1 && $(echo "$VERSION <= 9.6" | bc) -eq 1  ]] ||
         [[ $(echo "$VERSION >= 9.2" | bc) -eq 1 && $(echo "$VERSION <= 9.2" | bc) -eq 1  ]] ||
         [[ $(echo "$VERSION >= 9.3" | bc) -eq 1 && $(echo "$VERSION <= 9.3" | bc) -eq 1  ]] ||
         [[ $(echo "$VERSION >= 9.4" | bc) -eq 1 && $(echo "$VERSION <= 9.4" | bc) -eq 1 ]]

        }; then

        vulnerabilities+=("$NAME|$DESC|$SEVERITY|$SCORE|0")
        echo -e "${RED}[!] Vulnerable to CVE-2017-7546!${RESET}"
    else
        echo -e "${GREEN}[+] Not vulnerable to CVE-2017-7546.${RESET}"
    fi
}
