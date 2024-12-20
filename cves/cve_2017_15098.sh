#!/bin/bash

# https://www.cvedetails.com/cve/CVE-2017-15098/

cve_2017_15098(){
    echo -e "${YELLOW}[*] Checking CVE-2017-15098...${RESET}"

    local NAME="CVE-2017-15098"
    local DESC="Can crash the server or disclose a few bytes of server memory"
    local SEVERITY="HIGH"
    local SCORE="8.1"

    VERSION=$(psql -V | awk '{print $3}')

    if { [[ $(echo "$VERSION == 8.0" | bc) -eq 1  ]] ||
         [[ $(echo "$VERSION == 10" | bc) -eq 1  ]] ||
         [[ $(echo "$VERSION == 9.3" | bc) -eq 1  ]] ||
         [[ $(echo "$VERSION >= 9.3" | bc) -eq 1 && $(echo "$VERSION <= 9.3" | bc) -eq 1  ]] ||
         [[ $(echo "$VERSION >= 9.3" | bc) -eq 1 && $(echo "$VERSION <= 9.4" | bc) -eq 1  ]] ||
         [[ $(echo "$VERSION >= 9.4" | bc) -eq 1 && $(echo "$VERSION <= 9.4" | bc) -eq 1  ]] ||
         [[ $(echo "$VERSION >= 9.4" | bc) -eq 1 && $(echo "$VERSION <= 9.6" | bc) -eq 1 ]]

        }; then

        vulnerabilities+=("$NAME|$DESC|$SEVERITY|$SCORE|1")
        echo -e "${RED}[!] Vulnerable to CVE-2017-15098!${RESET}"
    else
        echo -e "${GREEN}[+] Not vulnerable to CVE-2017-15098.${RESET}"
    fi
}
