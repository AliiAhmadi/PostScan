#!/bin/bash

# Function to perform a PostgreSQL scan using Metasploit
metasploit_scan(){
    # Notify the user that the Metasploit scan is starting
    echo -e "${YELLOW}[*] Scanning PostgreSQL with Metasploit...${RESET}"

    # Assign input parameters to local variables
    local TARGET_IP=$1                                    # Target IP address
    local USERNAME=$2                                     # Database username
    local PORT=$3                                         # Database port
    local PASSWORD=$4                                     # Database password
    local LOG_FILE="metasploit_report.log"                # Log file for scan results
    local MODULES_FILE="postgres_modules.txt"             # File containing Metasploit modules
    local RESOURCE_FILE="postgres_scan.rc"                # Resource file for Metasploit commands

     # Clear the resource and log files
    > "$RESOURCE_FILE"
    > "$LOG_FILE"

    # Read each module from the modules file and configure the resource file
    while IFS= read -r MODULE || [[ -n "$MODULE"  ]]; do
        [[ -z "$MODULE"  ]] && continue    # Skip empty lines

        # Notify the user which module is being used
        echo -e "${YELLOW}[*] Using $MODULE resource.${RESET}"

        # Append module configuration to the resource file
        cat >> "$RESOURCE_FILE" <<EOF
use $MODULE
set RHOSTS $TARGET_IP
set RPORT $PORT
set USERNAME $USERNAME
set PASSWORD $PASSWORD
run
EOF

        done < "$MODULES_FILE"

        # Add the exit command to the resource file
        echo "exit" >> "$RESOURCE_FILE"

        # Run Metasploit with the resource file and log the output
        msfconsole -q -r "$RESOURCE_FILE" | tee -a "$LOG_FILE"

        # Log the scan completion time
        echo "Scan completed at $(date)" | tee -a "$LOG_FILE"

        # Remove the resource file after the scan
        rm -r "$RESOURCE_FILE"

        ##################################
}
