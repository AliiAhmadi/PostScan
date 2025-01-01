#!/bin/bash

# Directory containing CVE check scripts
CVE_DIR="./cves"

# Function to check for known PostgreSQL vulnerabilities
check_cves(){
    # Notify the user that the CVE check is starting
    echo -e "${YELLOW}[*] Checking for known PostgreSQL vulnerabilities...${RESET}"

    # Retrieve the PostgreSQL version and extract the version number
    # VERSION=$(psql -V 2>/dev/null | awk '{print $3}')


    # Loop through each CVE script in the CVE directory
    for cve_file in "$CVE_DIR"/*.sh; do
        sleep 1    # Pause for 1 second between checks for better readability

        # Load the CVE script
        source "$cve_file"

        # Extract the function name from the script filename (remove .sh extension)
        cve_function_name=$(basename "$cve_file" .sh)

        # Execute the CVE check function with database connection details
        $cve_function_name $DB_HOST $DB_USER $DB_NAME

    done
}
