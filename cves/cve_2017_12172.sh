#!/bin/bash

# https://www.cvedetails.com/cve/CVE-2017-12172/

cve_2017_12172(){
    echo -e "${YELLOW}[*] Checking CVE-2017-12172...${RESET}"

    local NAME="CVE-2017-12172"
    local DESC=""
    local SEVERITY="HIGH"
    local SCORE="7.2"

    VERSION=$(psql -V | awk '{print $3}')

    if { [[ $(echo "$VERSION == 10" | bc) -eq 1  ]] ||
         [[ $(echo "$VERSION == 9.2" | bc) -eq 1  ]] ||
         [[ $(echo "$VERSION >= 9.2.10" | bc) -eq 1 && $(echo "$VERSION <= 9.2.23" | bc) -eq 1  ]] ||
         [[ $(echo "$VERSION >= 9.3.10" | bc) -eq 1 && $(echo "$VERSION <= 9.3.19" | bc) -eq 1  ]] ||
         [[ $(echo "$VERSION >= 9.4.10" | bc) -eq 1 && $(echo "$VERSION <= 9.4.14" | bc) -eq 1 ]]  ||
         [[ $(echo "$VERSION >= 9.2.1" | bc) -eq 1 && $(echo "$VERSION <= 9.6.5" | bc) -eq 1 ]]  ||

        }; then

        vulnerabilities+=("$NAME|$DESC|$SEVERITY|$SCORE")
        echo -e "${RED}[!] Vulnerable to CVE-2017-12172!${RESET}"
    else
        echo -e "${GREEN}[+] Not vulnerable to CVE-2017-12172.${RESET}"
    fi
}