#!/bin/bash

# https://www.cvedetails.com/cve/CVE-2018-1052/

cve_2018_1052(){
    echo -e "${YELLOW}[*] Checking CVE-2018-1052...${RESET}"

    local NAME="CVE-2018-1052"
    local DESC="Memory disclosure vulnerability in table partitioning"
    local SEVERITY="MEDIUM"
    local SCORE="6.5"

    VERSION=$(psql -V | awk '{print $3}')

    if {
            [[ $(echo "$VERSION == 10.0" | bc) -eq 1  ]] ||
            [[ $(echo "$VERSION == 10.1" | bc) -eq 1  ]]

        }; then

        vulnerabilities+=("$NAME|$DESC|$SEVERITY|$SCORE|0")
        echo -e "${RED}[!] Vulnerable to CVE-2018-1052!${RESET}"
    else
        echo -e "${GREEN}[+] Not vulnerable to CVE-2018-1052.${RESET}"
    fi
}
