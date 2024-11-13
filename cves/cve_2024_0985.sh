#!/bin/bash

# https://www.cvedetails.com/cve/CVE-2024-0985/

cve_2024_0985(){
    echo -e "${YELLOW}[*] Checking CVE-2024-0985...${RESET}"

    local NAME="CVE-2024-0985"
    local DESC="Late privilege drop in REFRESH MATERIALIZED VIEW CONCURRENTLY"
    local SEVERITY="HIGH"
    local SCORE="8.0"

    VERSION=$(psql -V | awk '{print $3}')

    if { [[ $(echo "$VERSION >= 12.0" | bc) -eq 1 && $(echo "$VERSION < 12.18" | bc) -eq 1  ]] ||
         [[ $(echo "$VERSION >= 13.0" | bc) -eq 1 && $(echo "$VERSION < 13.14" | bc) -eq 1  ]] ||
         [[ $(echo "$VERSION >= 14.0" | bc) -eq 1 && $(echo "$VERSION < 14.11" | bc) -eq 1  ]] ||
         [[ $(echo "$VERSION >= 15.0" | bc) -eq 1 && $(echo "$VERSION < 15.6" | bc) -eq 1 ]]

        }; then

        vulnerabilities+=("$NAME|$DESC|$SEVERITY|$SCORE")
        echo -e "${RED}[!] Vulnerable to CVE-2024-0985!${RESET}"
    else
        echo -e "${GREEN}[+] Not vulnerable to CVE-2024-0985.${RESET}"
    fi
}
