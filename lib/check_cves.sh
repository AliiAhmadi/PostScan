#!/bin/bash

CVE_DIR="./cves"

check_cves(){
    echo -e "${YELLOW}[*] Checking for known PostgreSQL vulnerabilities...${RESET}"
    VERSION=$(psql -V 2>/dev/null | awk '{print $3}')

    for cve_file in "$CVE_DIR"/*.sh; do
        sleep 1
        source "$cve_file"
        cve_function_name=$(basename "$cve_file" .sh)
        $cve_function_name $DB_HOST $DB_USER $DB_NAME

    done
}
