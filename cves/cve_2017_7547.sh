#!/bin/bash

# https://www.cvedetails.com/cve/CVE-2017-7547/

cve_2017_7547(){
    echo -e "${YELLOW}[*] Checking CVE-2017-7547...${RESET}"

    local NAME="CVE-2017-7547"
    local DESC="allows remote authenticated attackers to retrieve passwords from the user mappings defined by the foreign server owners without actually having the privileges to do"
    local SEVERITY="HIGH"
    local SCORE="8.8"

    VERSION=$(psql -V | awk '{print $3}')

    if { [[ $(echo "$VERSION >= 9.2" | bc) -eq 1 && $(echo "$VERSION <= 9.6.3" | bc) -eq 1  ]] ||
         [[ $(echo "$VERSION >= 9.2.10" | bc) -eq 1 && $(echo "$VERSION <= 9.2.21" | bc) -eq 1  ]] ||
         [[ $(echo "$VERSION >= 9.3.10" | bc) -eq 1 && $(echo "$VERSION <= 9.3.17" | bc) -eq 1  ]] ||
         [[ $(echo "$VERSION >= 9.4.10" | bc) -eq 1 && $(echo "$VERSION <= 9.4.11" | bc) -eq 1 ]]

        }; then

        vulnerabilities+=("$NAME|$DESC|$SEVERITY|$SCORE")
        echo -e "${RED}[!] Vulnerable to CVE-2017-7547!${RESET}"
    else
        echo -e "${GREEN}[+] Not vulnerable to CVE-2017-7547.${RESET}"
    fi
}
