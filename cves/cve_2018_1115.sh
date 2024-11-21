cve_2018_1115(){
    echo -e "${YELLOW}[*] Checking CVE-2018-1115...${RESET}"

    local NAME="CVE-2018-1115"
    local DESC="Denial of Service with crafted database objects"
    local SEVERITY="MEDIUM"
    local SCORE="6.2"

    VERSION=$(psql -V | awk '{print $3}')

    if [[ $(echo "$VERSION >= 9.3" | bc) -eq 1 && $(echo "$VERSION < 9.6" | bc) -eq 1 ]]; then
        vulnerabilities+=("$NAME|$DESC|$SEVERITY|$SCORE|0")
        echo -e "${RED}[!] Vulnerable to CVE-2018-1115!${RESET}"
    else
        echo -e "${GREEN}[+] Not vulnerable to CVE-2018-1115.${RESET}"
    fi
}
