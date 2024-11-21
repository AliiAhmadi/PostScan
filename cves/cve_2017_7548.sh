#!/bin/bash

# https://www.cvedetails.com/cve/CVE-2017-7548/

cve_2017_7548(){
    echo -e "${YELLOW}[*] Checking CVE-2017-7548...${RESET}"

    local NAME="CVE-2017-7548"
    local DESC="Vulnerable to authorization flow, allowing remote authenticated attackers with no privileges on a large object to overwrite them, resulting in a denial of service"
    local SEVERITY="HIGH"
    local SCORE="7.5"

    VERSION=$(psql -V | awk '{print $3}')

    if { [[ $(echo "$VERSION >= 9.4" | bc) -eq 1 && $(echo "$VERSION < 9.4" | bc) -eq 1  ]] ||
         [[ $(echo "$VERSION >= 9.5" | bc) -eq 1 && $(echo "$VERSION < 9.5" | bc) -eq 1  ]] ||
         [[ $(echo "$VERSION >= 9.6" | bc) -eq 1 && $(echo "$VERSION < 9.6" | bc) -eq 1  ]]

        }; then

        vulnerabilities+=("$NAME|$DESC|$SEVERITY|$SCORE|0")
        echo -e "${RED}[!] Vulnerable to CVE-2017-7548!${RESET}"
    else
        echo -e "${GREEN}[+] Not vulnerable to CVE-2017-7548.${RESET}"
    fi
}
