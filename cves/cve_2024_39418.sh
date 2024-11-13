#!/bin/bash

# https://www.cvedetails.com/cve/CVE-2024-39418/

cve_2024_39418(){
    echo -e "${YELLOW}[*] Checking CVE-2024-39418...${RESET}"

    local NAME="CVE-2024-39418"
    local DESC="If UPDATE and SELECT policies forbid some rows that INSERT policies do not forbid, could store such rows"
    local SEVERITY="MEDIUM"
    local SCORE="4.3"

    VERSION=$(psql -V | awk '{print $3}')

    if { [[ $(echo "$VERSION >= 15.0" | bc) -eq 1 && $(echo "$VERSION < 15.4" | bc) -eq 1  ]]

        }; then

        vulnerabilities+=("$NAME|$DESC|$SEVERITY|$SCORE")
        echo -e "${RED}[!] Vulnerable to CVE-2024-39418!${RESET}"
    else
        echo -e "${GREEN}[+] Not vulnerable to CVE-2024-39418.${RESET}"
    fi
}
