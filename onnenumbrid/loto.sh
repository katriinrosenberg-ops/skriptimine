#!/bin/bash

TEMP_FILE=$(mktemp)
trap 'rm -f "$TEMP_FILE"' EXIT

while [ $(wc -l < "$TEMP_FILE") -lt 5 ]; do
    
    num=$(( (RANDOM % 50) + 1 ))

    
    if ! grep -qx "$num" "$TEMP_FILE"; then
        echo "$num" >> "$TEMP_FILE"
    fi
done

praegune_aeg=$(date "+%Y-%m-%d %H:%M:%S")
numbrid=$(tr '\n' ' ' < "$TEMP_FILE")


echo "---------------------------------"
echo "5 lotonumbrit on edukalt genereeritud!"
echo "Vali väljund:"
echo "1) Kuva terminalis"
echo "2) Salvesta faili"
read -p "Sisesta valik (1 või 2): " valik


tulemus="$praegune_aeg - Lotonumbrid: $numbrid"

if [ "$valik" = "1" ]; then
    echo -e "\n--- TULEMUS ---"
    echo "$tulemus"
elif [ "$valik" = "2" ]; then
    read -p "Sisesta faili nimi (vaikimisi: lotonumbrid.txt): " failinimi
    
    
    if [ -z "$failinimi" ]; then
        failinimi="lotonumbrid.txt"
    fi


    echo "$tulemus" >> "$failinimi"
    echo "Tulemus salvestatud faili '$failinimi'."
else
    echo -e "\nTundmatu valik. Kuvatakse tulemus terminalis:"
    echo "$tulemus"
fi
