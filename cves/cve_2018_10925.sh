cve_2018_10925(){
    echo -e "${YELLOW}[*] Checking CVE-2018-10925...${RESET}"

    local NAME="CVE-2018-10925"
    local DESC="Memory disclosure with crafted SQL queries"
    local SEVERITY="MEDIUM"
    local SCORE="5.5"

    VERSION=$(psql -V | awk '{print $3}')

    if [[ $(echo "$VERSION >= 9.5" | bc) -eq 1 && $(echo "$VERSION < 10.5" | bc) -eq 1 ]]; then
        vulnerabilities+=("$NAME|$DESC|$SEVERITY|$SCORE")
        echo -e "${RED}[!] Vulnerable to CVE-2018-10925!${RESET}"
    else
        echo -e "${GREEN}[+] Not vulnerable to CVE-2018-10925.${RESET}"
    fi
}
