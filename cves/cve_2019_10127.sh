cve_2019_10127(){
    echo -e "${YELLOW}[*] Checking CVE-2019-10127...${RESET}"

    local NAME="CVE-2019-10127"
    local DESC="Memory disclosure in partition routing"
    local SEVERITY="MEDIUM"
    local SCORE="5.3"

    VERSION=$(psql -V | awk '{print $3}')

    if [[ $(echo "$VERSION >= 10.0" | bc) -eq 1 && $(echo "$VERSION < 11.3" | bc) -eq 1 ]]; then
        vulnerabilities+=("$NAME|$DESC|$SEVERITY|$SCORE")
        echo -e "${RED}[!] Vulnerable to CVE-2019-10127!${RESET}"
    else
        echo -e "${GREEN}[+] Not vulnerable to CVE-2019-10127.${RESET}"
    fi
}
