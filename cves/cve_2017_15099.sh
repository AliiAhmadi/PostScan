#!/bin/bash

# https://www.cvedetails.com/cve/CVE-2017-15099/

cve_2017_15099(){
    echo -e "${YELLOW}[*] Checking CVE-2017-15099...${RESET}"

    local NAME="CVE-2017-15099"
    local DESC="discloses table contents that the invoker lacks privilege to read"
    local SEVERITY="MEDIUM"
    local SCORE="6.5"

    VERSION=$(psql -V | awk '{print $3}')

    if { [[ $(echo "$VERSION == 9.0" | bc) -eq 1   ]] || 
         [[ $(echo "$VERSION == 10.0" | bc) -eq 1  ]] ||
         [[ $(echo "$VERSION >= 9.5.0" | bc) -eq 1 && $(echo "$VERSION <= 9.6.5" | bc) -eq 1  ]] ||

        }; then

        vulnerabilities+=("$NAME|$DESC|$SEVERITY|$SCORE")
        echo -e "${RED}[!] Vulnerable to CVE-2017-15099!${RESET}"
    else
        echo -e "${GREEN}[+] Not vulnerable to CVE-2017-15099.${RESET}"
    fi
}
