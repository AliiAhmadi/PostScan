#!/bin/bash

cve_2019_10130(){
        echo -e "${YELLOW}[*] Checking CVE-2019-10130...${RESET}"

        local NAME="CVE-2019-10130"
        local DESC="attacker can exploit this to read the most common values of certain columns"
        local SEVERITY="MEDIUM"
        local SCORE="4.0"

        VERSION=$(psql -V | awk '{print $3}' | tr -d '\n')

        if { [[ $(echo "$VERSION >= 10.0" | bc) -eq 1 && $(echo "$VERSION < 10.8" | bc) -eq 1 ]] ||
             [[ $(echo "$VERSION >= 11.0" | bc) -eq 1 && $(echo "$VERSION < 11.3" | bc) -eq 1 ]] ||
             [[ $(echo "$VERSION >= 9.5" | bc) -eq 1 && $(echo "$VERSION < 9.5" | bc) -eq 1 ]] ||
             [[ $(echo "$VERSION >= 9.6" | bc) -eq 1 && $(echo "$VERSION < 9.6" | bc) -eq 1 ]]
            }; then
                vulnerabilities+=("$NAME|$DESC|$SEVERITY|$SCORE|0")
                echo -e "${RED}[!] Vulnerable to CVE-2019-10130!${RESET}"
        else
                echo -e "${GREEN}[+] Not vulnerable to CVE-2019-10130.${RESET}"
        fi

}
