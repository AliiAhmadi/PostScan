#!/bin/bash

cve_2018_1058() {
    local target_ip=$1
    local username=$2
    local database=$3

    local payload="SET search_path = public, pg_catalog; DROP TABLE IF EXISTS test_table; CREATE TABLE test_table(id SERIAL PRIMARY KEY);"

    echo -e "${YELLOW}[*] Checking CVE-2018-1058: SQL Injection via Schema Modification...${RESET}"

    output=$(psql -h "$target_ip" -U "$username" -d "$database" -c "$payload" 2>&1)

    if [[ "$output" == *"CREATE TABLE"* ]]; then
        echo -e "${RED}[!] Vulnerable to CVE-2018-1058!${RESET}"

        local NAME="CVE-2018-1058"
        local DESCRIPTION="SQL Injection via Schema Modification"
        local SEVERITY="HIGH"
        local SCORE="7.5"
        vulnerabilities+=("$NAME|$DESCRIPTION|$SEVERITY|$SCORE|0")

    else
        echo -e "${GREEN}[+] Not vulnerable to CVE-2024-0985.${RESET}"
    fi
}
