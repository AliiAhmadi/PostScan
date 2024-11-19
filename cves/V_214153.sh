#!/bin/bash


V_214153(){
    echo -e "${YELLOW}[*] Checking if OpenSSL is FIPS compliant...${RESET}"

    local NAME="V-214153"
    local DESCRIPTION="PostgreSQL must use NIST FIPS 140-2 or 140-3 validated cryptographic modules for cryptographic operations"
    local SEVERITY="HIGH"
    local SCORE=""
    local DONE="0"

    openssl_version=$(openssl version)
    if [[ "$openssl_version" == *"fips"* ]]; then
        echo -e "${GREEN}[+] FIPS is already enabled in OpenSSL.${RESET}"
        return 0
    else
        echo -e "${RED}[!] FIPS is NOT enabled in OpenSSL. Attempting to fix...${RESET}"

        if [ "$(cat /proc/sys/crypto/fips_enabled)" != "1"  ]; then
                sudo fips-mode-setup --enable
        fi

        if ! rpm -q openssl-fips &>/dev/null; then
            echo -e "${YELLOW}[*] Installing openssl-fips package...${RESET}"
            sudo dnf install -y openssl-fips
        fi


        if [ -f /etc/system-fips  ]; then
            sudo touch /etc/system-fips
            echo -e "${GREEN}[+] FIPS mode enabled system-wide.${RESET}"
        else
            echo -e "${RED}[!] FIPS mode cannot be enabled system-wide. Manual intervention required.${RESET}"
            vulnerabilities+=("$NAME|$DESCRIPTION|$SEVERITY|$SCORE|$DONE")
            return 1
        fi

        openssl_conf="/etc/pki/tls/openssl.cnf"
        if grep -q "fips_mode = yes" "$openssl_conf"; then
            echo -e "${GREEN}[+] OpenSSL already configured for FIPS.${RESET}"
        else
            echo -e "${YELLOW}[!] Updating OpenSSL configuration for FIPS...${RESET}"
            sudo sed -i '/^\[ openssl_init \]/a fips_mode = yes' "$openssl_conf"
        fi

        echo -e "${YELLOW}[!] Restarting services to apply changes...${RESET}"
        sudo systemctl restart postgresql

        echo -e "${GREEN}[+] FIPS mode enabled successfully!${RESET}"
        DONE="1"
        vulnerabilities+=("$NAME|$DESCRIPTION|$SEVERITY|$SCORE|$DONE")
    fi
}
