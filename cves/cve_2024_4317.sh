#!/bin/bash

cve_2024_4317(){
    echo -e "${YELLOW}[*] Checking CVE-2024-4317...${RESET}"

    local NAME="CVE-2024-4317"
    local DESC="Missing authorization in PostgreSQL built-in views pg_stats_ext"
    local SEVERITY="LOW"
    local SCORE="3.1"

    VERSION=$(psql -V | awk '{print $3}')

    if { [[ $(echo "$VERSION >= 14.0" | bc) -eq 1 && $(echo "$VERSION < 14.12" | bc) -eq 1  ]] ||
         [[ $(echo "$VERSION >= 15.0" | bc) -eq 1 && $(echo "$VERSION < 15.7" | bc) -eq 1  ]] ||
         [[ $(echo "$VERSION >= 16.0" | bc) -eq 1 && $(echo "$VERSION < 16.3" | bc) -eq 1  ]]

        }; then

        vulnerabilities+=("$NAME|$DESC|$SEVERITY|$SCORE")
        echo -e "${RED}[!] Vulnerable to CVE-2024-4317!${RESET}"
    else
        echo -e "${GREEN}[+] Not vulnerable to CVE-2024-4317.${RESET}"
    fi
}
