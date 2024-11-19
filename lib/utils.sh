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

#print_vulnerability_table(){
#    printf "\n"
#    printf "${BLUE}%-25s %-50s %-15s %-10s\n${RESET}" "Vulnerability Name" "Description" "Severity" "Base Score"
#    printf "${BLUE}%-25s %-50s %-15s %-10s\n${RESET}" "--------------------" "---------------------------------------------------------------------------------------------------" "---------------" "----------"
#
#    for vulnerability in "${vulnerabilities[@]}"; do
#        IFS='|' read -r name description severity score <<< "$vulnerability"
#        printf "${RED}%-25s %-50s %-15s %-10s\n${RESET}" "$name" "$description" "$severity" "$score"
#
#    done
#}

print_vulnerability_table(){
    MAX_DESC_LENGTH=50
    printf "\n"

    printf "${BLUE}%-25s %-50s %-15s %-10s\n${RESET}" "Vulnerability Name" "Description" "Severity" "Base Score"
    printf "${BLUE}%-25s %-50s %-15s %-10s\n${RESET}" "--------------------" "--------------------------------------------------" "---------------" "----------"

    for vulnerability in "${vulnerabilities[@]}"; do
        IFS='|' read -r name description severity score <<< "$vulnerability"
        if [ ${#description} -gt $MAX_DESC_LENGTH  ]; then
            description="${description:0:$((MAX_DESC_LENGTH-3))}..."
        fi

        printf "${RED}%-25s %-50s %-15s %-10s\n${RESET}" "$name" "$description" "$severity" "$score"
    done
}

export_csv(){
    output_file="vulnerabilities.csv"

    if [ -f "$output_file" ]; then
        read -p "$(echo -e "${RED}The file '$output_file' already exists. Do you want to overwrite it? (y/n): ${RESET}")" choice

        if [[ "$choice" != "y" && "$choice" != "Y" ]]; then
            return
        fi
    fi

    echo "Name,Description,Severity,Score,Done" > "$output_file"

    for entry in "${vulnerabilities[@]}"; do
        echo "$entry" | tr '|' ',' >> "$output_file"
    done
}
