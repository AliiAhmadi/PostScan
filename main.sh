#!/bin/bash

# Define color codes for terminal text formatting
RED='\033[0;31m'                 # Red color
GREEN='\033[0;1;38;5;34m'        # Bright green color
YELLOW='\033[0;1;38;5;154m'      # Yellow color
BLUE='\033[1;34m'                # Blue color
RESET='\033[0m'                  # Reset to default terminal color


# Initialize an empty array to store vulnerabilities read from a file
# This array will later be used to generate the final output
vulnerabilities=()


# Function to display a welcome banner with the PostgreSQL version
display_banner(){
    # Retrieve the PostgreSQL version using psql command
    VERSION=$(psql -V | awk '{print $3}')

    # Check if the version retrieval was successful
    if [ $? -ne 0 ]; then
        echo -e "${RED}Error: Unable to retrieve PostgreSQL version.${RESET}"
        exit 1  # Exit with an error code if version retrieval fails
    fi

    # Display the banner with the PostgreSQL version in green color
    echo -e "\033[1;32m"
    echo "==========================================="
    echo "   Welcome to PostScan - PostgreSQL v$VERSION"
    echo "==========================================="
    echo -e "\033[0m" # Reset the text color to default
}

# call Display banner function
display_banner

# Load configuration and library scripts from the script's directory
source "$(dirname "$0")/config.sh"                 # Load configuration file
source "$(dirname "$0")/lib/check_cves.sh"         # Load CVE check functions
source "$(dirname "$0")/lib/check_configs.sh"      # Load security configuration check functions
source "$(dirname "$0")/lib/utils.sh"              # Load utility functions
source "$(dirname "$0")/lib/metasploit.sh"         # Load Metasploit-related functions

# Notify the user that the PostgreSQL security scan is starting
echo -e "${YELLOW}[*] Starting PostgreSQL Security Scan...${RESET}"
sleep 2    # Pause for 2 seconds for better user experience

# Execute security checks
check_postgres_running    # Check if PostgreSQL is running
check_cves                # Check for known vulnerabilities
check_security_configs    # Check security configurations

# Notify the user that the security scan has completed
echo -e "${YELLOW}[*] Security scan completed.\n${RESET}"

# Export the scan results to a CSV file
export_csv

# Perform a Metasploit scan using the provided database credentials
metasploit_scan $DB_HOST $DB_USER $DB_PORT $DB_PASSWORD

# Display the vulnerabilities in a formatted table
print_vulnerability_table

