#!/bin/bash


check_postgres_running(){
    echo -e "${YELLOW}[*] Checking if PostgreSQL service is running...${RESET}"
    systemctl is-active --quiet postgresql
    if [[ $? -ne 0  ]]; then
        echo -e "${RED}[-] PostgreSQL is not running!${RESET}"
        exit 1
    else
        echo -e "${GREEN}[+] PostgreSQL is running.${RESET}"
    fi
}

print_vulnerability_table(){
    printf "${BLUE}%-25s %-50s %-15s %-10s\n${RESET}" "Vulnerability Name" "Description" "Severity" "Base Score"
    printf "${BLUE}%-25s %-50s %-15s %-10s\n${RESET}" "--------------------" "--------------------------------------------------" "---------------" "----------"

    for vulnerability in "${vulnerabilities[@]}"; do
        IFS='|' read -r name description severity score <<< "$vulnerability"
        printf "${RED}%-25s %-50s %-15s %-10s\n${RESET}" "$name" "$description" "$severity" "$score"

    done
}
