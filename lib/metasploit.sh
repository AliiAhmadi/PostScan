#!/bin/bash

metasploit_scan(){
    echo -e "${YELLOW}[*] Scanning PostgreSQL with Metasploit...${RESET}"

    local TARGET_IP=$1
    local USERNAME=$2
    local PORT=$3
    local PASSWORD=$4
    local LOG_FILE="metasploit_report.log"
    local MODULES_FILE="postgres_modules.txt"
    local RESOURCE_FILE="postgres_scan.rc"

    > "$RESOURCE_FILE"
    > "$LOG_FILE"


    while IFS= read -r MODULE || [[ -n "$MODULE"  ]]; do
        [[ -z "$MODULE"  ]] && continue

        echo -e "${YELLOW}[*] Using $MODULE resource.${RESET}"

        cat >> "$RESOURCE_FILE" <<EOF
use $MODULE
set RHOSTS $TARGET_IP
set RPORT $PORT
set USERNAME $USERNAME
set PASSWORD $PASSWORD
run
EOF

        done < "$MODULES_FILE"

        echo "exit" >> "$RESOURCE_FILE"
        msfconsole -q -r "$RESOURCE_FILE" | tee -a "$LOG_FILE"
        echo "Scan completed at $(date)" | tee -a "$LOG_FILE"
        rm -r "$RESOURCE_FILE"

        ##################################
}
