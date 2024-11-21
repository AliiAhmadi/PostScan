cve_2019_10128(){
    echo -e "${YELLOW}[*] Checking CVE-2019-10128...${RESET}"

    local NAME="CVE-2019-10128"
    local DESC="Access control vulnerability in Windows installer"
    local SEVERITY="HIGH"
    local SCORE="7.8"

    VERSION=$(psql -V | awk '{print $3}')

    if [[ $(echo "$VERSION >= 9.4" | bc) -eq 1 && $(echo "$VERSION < 11.3" | bc) -eq 1 ]]; then
        vulnerabilities+=("$NAME|$DESC|$SEVERITY|$SCORE|1")
        echo -e "${RED}[!] Vulnerable to CVE-2019-10128!${RESET}"
    else
        echo -e "${GREEN}[+] Not vulnerable to CVE-2019-10128.${RESET}"
    fi
}
