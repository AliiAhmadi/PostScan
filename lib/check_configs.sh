#!/bin/bash


check_security_configs(){
    echo -e "${YELLOW}[*] Checking PostgreSQL configuration...${RESET}"
    CONFIG_FILE="/var/lib/pgsql/data/postgresql.conf"


    if [[ ! -f $CONFIG_FILE  ]]; then
        echo -e "${RED}[-] Configuration file not found!${RESET}"
        return 1
    fi

    if grep -q "^listen_addresses = '0.0.0.0'" "$CONFIG_FILE"; then
        echo -e "${RED}[-] Warning: PostgreSQL is listening on all addresses!${RESET}"
    else
        echo -e "${GREEN}[+] Secure listening address configuration.${RESET}"
    fi

    if grep -q "^ssl = off" "$CONFIG_FILE"; then
        echo -e "${RED}[-] Warning: SSL is disabled!${RESET}"
    else
        echo -e "${GREEN}[+] SSL is enabled.${RESET}"
    fi
}
