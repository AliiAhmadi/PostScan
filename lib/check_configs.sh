#!/bin/bash


# Function to check PostgreSQL security configurations
check_security_configs(){
    echo -e "${YELLOW}[*] Checking PostgreSQL configuration...${RESET}"
    CONFIG_FILE="/var/lib/pgsql/data/pg_hba.conf"     # Path to PostgreSQL configuration file


    # Check if the configuration file exists
    if [[ ! -f $CONFIG_FILE  ]]; then
        echo -e "${RED}[-] Configuration file not found!${RESET}"
        return 1    # Exit the function with an error code
    fi

    # Check if PostgreSQL is listening on all addresses (0.0.0.0)
    if grep -q "^listen_addresses = '0.0.0.0'" "$CONFIG_FILE"; then
        echo -e "${RED}[-] Warning: PostgreSQL is listening on all addresses!${RESET}"
    else
        echo -e "${GREEN}[+] Secure listening address configuration.${RESET}"
    fi

    # Check if SSL is disabled in the configuration
    if grep -q "^ssl = off" "$CONFIG_FILE"; then
        echo -e "${RED}[-] Warning: SSL is disabled!${RESET}"
    else
        echo -e "${GREEN}[+] SSL is enabled.${RESET}"
    fi
}
