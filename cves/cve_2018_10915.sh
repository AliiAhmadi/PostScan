cve_2018_10915(){
    echo -e "${YELLOW}[*] Checking CVE-2018-10915...${RESET}"

    local NAME="CVE-2018-10915"
    local DESC="Access control bypass in certain configurations"
    local SEVERITY="HIGH"
    local SCORE="7.5"

    VERSION=$(psql -V | awk '{print $3}')

    if [[ $(echo "$VERSION >= 9.6" | bc) -eq 1 && $(echo "$VERSION < 10.3" | bc) -eq 1 ]]; then
        vulnerabilities+=("$NAME|$DESC|$SEVERITY|$SCORE|0")
        echo -e "${RED}[!] Vulnerable to CVE-2018-10915!${RESET}"
    else
        echo -e "${GREEN}[+] Not vulnerable to CVE-2018-10915.${RESET}"
    fi
}
