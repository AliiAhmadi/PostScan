#!/bin/bash

# Function to check if the PostgreSQL service is running
check_postgres_running(){
    # Notify the user that the PostgreSQL service status is being checked
    echo -e "${YELLOW}[*] Checking if PostgreSQL service is running...${RESET}"

    # Check if the PostgreSQL service is active
    systemctl is-active --quiet postgresql

    # Evaluate the exit status of the previous command
    if [[ $? -ne 0  ]]; then
        # If PostgreSQL is not running, display an error message and exit
        echo -e "${RED}[-] PostgreSQL is not running!${RESET}"
        exit 1
    else
        # If PostgreSQL is running, display a success message
        echo -e "${GREEN}[+] PostgreSQL is running.${RESET}"
    fi
}

# Function to print a formatted table of vulnerabilities
print_vulnerability_table(){
    # Define the maximum length for the description field
    MAX_DESC_LENGTH=50
    printf "\n"

    # Print the table header with column names
    printf "${BLUE}%-25s %-50s %-15s %-10s\n${RESET}" "Vulnerability Name" "Description" "Severity" "Base Score"
    printf "${BLUE}%-25s %-50s %-15s %-10s\n${RESET}" "--------------------" "--------------------------------------------------" "---------------" "----------"

    # Loop through each vulnerability in the vulnerabilities array
    for vulnerability in "${vulnerabilities[@]}"; do
        # Split the vulnerability string into its components
        IFS='|' read -r name description severity score <<< "$vulnerability"

        # Truncate the description if it exceeds the maximum length
        if [ ${#description} -gt $MAX_DESC_LENGTH  ]; then
            description="${description:0:$((MAX_DESC_LENGTH-3))}..."
        fi

        # Print the vulnerability details in a formatted row
        printf "${RED}%-25s %-50s %-15s %-10s\n${RESET}" "$name" "$description" "$severity" "$score"
    done
}


# Function to export vulnerabilities to a CSV file
export_csv(){
    # Define the output CSV file name
    output_file="vulnerabilities.csv"

    # Check if the file already exists
    if [ -f "$output_file" ]; then

        # Prompt the user to confirm overwriting the file
        read -p "$(echo -e "${RED}The file '$output_file' already exists. Do you want to overwrite it? (y/n): ${RESET}")" choice

        # If the user does not confirm, exit the function
        if [[ "$choice" != "y" && "$choice" != "Y" ]]; then
            return
        fi
    fi

    # Write the CSV header to the file
    echo "Name,Description,Severity,Score,Done" > "$output_file"

    # Loop through each vulnerability entry and append it to the CSV file
    for entry in "${vulnerabilities[@]}"; do

        # Replace the delimiter '|' with ',' and write to the file
        echo "$entry" | tr '|' ',' >> "$output_file"
    done
}
