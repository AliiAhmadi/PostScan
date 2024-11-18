#!/bin/bash

cve_2019_9193() {
    local target_ip=$1
    local username=$2
    local database=$3

    echo -e "${YELLOW}[*] Checking CVE-2019-9193: Bypass Authentication with postgres_fdw...${RESET}"

    extension_check=$(psql -h "$target_ip" -U "$username" -d "$database" -t -c "SELECT EXISTS(SELECT 1 FROM pg_extension WHERE extname = 'postgres_fdw');")

    if [[ "$extension_check" == " t" ]]; then
        echo -e "${GREEN}[+] postgres_fdw extension is installed on the target database.${RESET}"
    else
        echo -e "${RED}[!] postgres_fdw extension is not installed on the target database.${RESET}"
        return 1
    fi

    server_output=$(psql -h "$target_ip" -U "$username" -d "$database" -c "CREATE SERVER foreign_server FOREIGN DATA WRAPPER postgres_fdw OPTIONS (host '$target_ip', dbname '$database');" 2>&1)


    if [[ "$server_output" == *"ERROR"* ]]; then
        echo -e "${GREEN}[+] Not vulnerable to CVE-2019-9193.${RESET}"
    else
        echo -e "${RED}[!] Vulnerable to CVE-2019-9193!${RESET}"
        local NAME="CVE-2019-9193"
        local DESCRIPTION="Bypass Authentication with postgres_fdw"
        local SEVERITY="HIGH"
        local SCORE="7.8"

        vulnerabilities+=("$NAME|$DESCRIPTION|$SEVERITY|$SCORE")
    fi
}
