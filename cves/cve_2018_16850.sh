cve_2018_16850(){
    echo -e "${YELLOW}[*] Checking CVE-2018-16850...${RESET}"

    local NAME="CVE-2018-16850"
    local DESC="Execution of arbitrary SQL code via CREATE RULE"
    local SEVERITY="HIGH"
    local SCORE="7.2"

    VERSION=$(psql -V | awk '{print $3}')

    if [[ $(echo "$VERSION >= 10.0" | bc) -eq 1 && $(echo "$VERSION < 11.2" | bc) -eq 1 ]]; then
        vulnerabilities+=("$NAME|$DESC|$SEVERITY|$SCORE|0")
        echo -e "${RED}[!] Vulnerable to CVE-2018-16850!${RESET}"
    else
        echo -e "${GREEN}[+] Not vulnerable to CVE-2018-16850.${RESET}"
    fi
}
