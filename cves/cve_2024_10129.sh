#!/bin/bash

# https://www.cvedetails.com/cve/CVE-2019-10129/

cve_2024_10129(){
    echo -e "${YELLOW}[*] Checking CVE-2019-10129...${RESET}"

    local NAME="CVE-2019-10129"
    local DESC="Using a purpose-crafted insert to a partitioned table, an attacker can read arbitrary bytes of server memory."
    local SEVERITY="MEDIUM"
    local SCORE="6.5"

    VERSION=$(psql -V | awk '{print $3}')

    if { [[ $(echo "$VERSION >= 11.0" | bc) -eq 1 && $(echo "$VERSION < 11.3" | bc) -eq 1  ]]

        }; then

        vulnerabilities+=("$NAME|$DESC|$SEVERITY|$SCORE|0")
        echo -e "${RED}[!] Vulnerable to CVE-2019-10129!${RESET}"
    else
        echo -e "${GREEN}[+] Not vulnerable to CVE-2019-10129.${RESET}"
    fi
}
