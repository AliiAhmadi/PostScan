#!/bin/bash

cve_2024_7348(){
    echo -e "${YELLOW}[*] Checking CVE-2024-7348...${RESET}"

    local NAME="CVE-2024-7348"
    local DESC="(TOCTOU) race condition in pg_dump"
    local SEVERITY="HIGH"
    local SCORE="8.8"

    VERSION=$(psql -V | awk '{print $3}')

    if { [[ $(echo "$VERSION >= 12.0" | bc) -eq 1 && $(echo "$VERSION < 12.20" | bc) -eq 1  ]] ||
         [[ $(echo "$VERSION >= 13.0" | bc) -eq 1 && $(echo "$VERSION < 13.16" | bc) -eq 1  ]] ||
         [[ $(echo "$VERSION >= 14.0" | bc) -eq 1 && $(echo "$VERSION < 14.13" | bc) -eq 1  ]] ||
         [[ $(echo "$VERSION >= 15.0" | bc) -eq 1 && $(echo "$VERSION < 15.8" | bc) -eq 1  ]] ||
         [[ $(echo "$VERSION >= 16.0" | bc) -eq 1 && $(echo "$VERSION < 16.4" | bc) -eq 1  ]]

        }; then

        vulnerabilities+=("$NAME|$DESC|$SEVERITY|$SCORE")
        echo -e "${RED}[!] Vulnerable to CVE-2024-7348!${RESET}"
    else
        echo -e "${GREEN}[+] Not vulnerable to CVE-2024-7348.${RESET}"
    fi
}
