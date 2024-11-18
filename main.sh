#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;1;38;5;34m'
YELLOW='\033[0;1;38;5;154m'
BLUE='\033[1;34m'
RESET='\033[0m'

vulnerabilities=()


display_banner(){
    VERSION=$(psql -V | awk '{print $3}')

    if [ $? -ne 0 ]; then
        echo -e "${RED}Error: Unable to retrieve PostgreSQL version.${RESET}"
        exit 1
    fi

    echo -e "\033[1;32m"
    echo "==========================================="
    echo "   Welcome to PostScan - PostgreSQL v$VERSION"
    echo "==========================================="
    echo -e "\033[0m"
}

display_banner

source "$(dirname "$0")/config.sh"
source "$(dirname "$0")/lib/check_cves.sh"
source "$(dirname "$0")/lib/check_configs.sh"
source "$(dirname "$0")/lib/utils.sh"

echo -e "${YELLOW}[*] Starting PostgreSQL Security Scan...${RESET}"
sleep 2

check_postgres_running
check_cves
check_security_configs

echo -e "${YELLOW}[*] Security scan completed.\n${RESET}"

export_csv
print_vulnerability_table
