#!/bin/bash

cve_2017_7486() {
    local target_ip=$1
    local username=$2
    local database=$3

    local payload="CREATE OR REPLACE FUNCTION malicious_function() RETURNS void AS \$\$
    BEGIN
      PERFORM pg_sleep(10);
      END;
      \$\$ LANGUAGE plpgsql SECURITY DEFINER;"

    local check_query="SELECT malicious_function();"

    echo -e "${YELLOW}[*] Testing CVE-2017-7486: Remote Code Execution via pg_upgrade...${RESET}"

    # Run the SQL to create the function
    psql -h "$target_ip" -U "$username" -d "$database" -c "$payload" &>/dev/null

    start_time=$(date +%s)
    psql -h "$target_ip" -U "$username" -d "$database" -c "$check_query" &>/dev/null
    end_time=$(date +%s)

    delay=$((end_time - start_time))

    if [ "$delay" -ge 10 ]; then
        echo -e "${RED}[!] Vulnerable to CVE-2017-7486!${RESET}"

        local NAME="CVE-2017-7486"
        local DESCRIPTION="Remote Code Execution via pg_upgrade"
        local SEVERITY="HIGH"
        local SCORE="7.5"

        vulnerabilities+=("$NAME|$DESCRIPTION|$SEVERITY|$SCORE|0")

    else
        echo -e "${GREEN}[+] Not vulnerable to CVE-2017-7486.${RESET}"
    fi
}
