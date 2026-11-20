#!/bin/bash
#
# MySQL 9.7 LTS andmebaasiserveri automaatse paigaldamise skript (Debian 13)
#
# Aktiveerime vearežiimi: kui mõni käsk ebaõnnestub, lõpetab skript kohe töö
set -e

# Kontrollime, kas mysql-server pakett on juba süsteemis paigaldatud
MYSQL=$(dpkg-query -W -f='${Status}' mysql-server 2>/dev/null | grep -c 'ok installed' || true)

# Kui MYSQL muutuja väärtus on 0, siis alustame paigaldamist
if [ $MYSQL -eq 0 ]; then
    echo "Paigaldame MySQL 9.7 LTS serveri ja vajalikud lisad..."

    # Määrame mitteküsimuste režiimi, et apt ja dpkg ei avaks interaktiivseid aknaid
    export DEBIAN_FRONTEND=noninteractive

    # Uuendame paketiandmebaasi ja paigaldame vajalikud tööriistad
    apt update
    apt install -y gnupg ca-certificates debconf-utils wget

    # --- 1. Valmistame ette vastused mysql-apt-config paketi küsimustele ---
    echo "mysql-apt-config mysql-apt-config/select-server select mysql-9.7-lts" | debconf-set-selections
    echo "mysql-apt-config mysql-apt-config/select-tools select Disabled" | debconf-set-selections
    echo "mysql-apt-config mysql-apt-config/select-product select Ok" | debconf-set-selections

    # --- 2. Määrame ette MySQL root-kasutaja parooli ("qwerty") ---
    echo "mysql-community-server mysql-community-server/root-pass password qwerty" | debconf-set-selections
    echo "mysql-community-server mysql-community-server/re-root-pass password qwerty" | debconf-set-selections

    # --- 3. Valime soovitatud paroolikrüpteerimise meetodi ---
    echo "mysql-community-server mysql-server/default-auth-override select Use Strong Password Encryption (RECOMMENDED)" | debconf-set-selections

    # --- 4. Laeme alla ja paigaldame aktuaalse MySQL APT repositooriumi paketi (0.8.40-1) ---
    wget -O /tmp/mysql-apt-config_0.8.40-1_all.deb https://dev.mysql.com/get/mysql-apt-config_0.8.40-1_all.deb
    dpkg -i /tmp/mysql-apt-config_0.8.40-1_all.deb
    rm -f /tmp/mysql-apt-config_0.8.40-1_all.deb

    # --- 5. Uuendame paketiloendi ja paigaldame MySQL serveri ---
    apt update
    apt install -y mysql-server

    # --- 6. Käivitame MySQL teenuse ja lubame automaatse käivituse ---
    systemctl enable --now mysql

    echo "Valmis: MySQL 9.7 LTS server on paigaldatud. Root-parool: qwerty"
    mysql --version

# Kui MYSQL muutuja väärtus on 1, siis on teenus juba paigaldatud
elif [ $MYSQL -eq 1 ]; then
    echo "MySQL on juba paigaldatud"
    # Kuvame paigaldatud versiooni ja kontrollime teenuse olekut
    mysql --version
    service mysql start
    service mysql status
fi
