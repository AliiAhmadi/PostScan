#!/bin/bash


V_259799(){
    echo -e "${YELLOW}[*] Checking PostgreSQL version...${RESET}"

    current_version=$(sudo -u postgres psql --version | awk '{print $3}')
    installed_versions=$(rpm -qa | grep postgres)
    latest_version=$(curl -s http://www.postgresql.org/support/versioning/ | grep -oP 'PostgreSQL \K[\d.]+(?= \(latest\))' | head -n 1)


    if [[ "$current_version" != "$latest_version"  ]]; then
        echo -e "${RED}[!] PostgreSQL is not up to date.${RESET}"
        echo -e "${YELLOW}[*] Updating PostgreSQL using RPM...${RESET}"

        sudo yum install -y postgresql-server postgresql-contrib
        sudo systemctl restart postgresql.service

        echo -e "${GREEN}[+] Upgrade completed successfully.${RESET}"
    else
        echo -e "${GREEN}[+] PostgreSQL is up to date.${RESET}"
    fi
}
