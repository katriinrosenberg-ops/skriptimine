#!/bin/bash
# Praktiline töö – Elroni rongiinfo Bash-skript

# Värvikoodid
PUNANE='\033[0;31m'
ROHELINE='\033[0;32m'
NC='\033[0m' # Värvi lähtestamine

# 1. Marsruudi valimine
echo "ELRONI RONGIINFO"
echo ""
echo "Vali marsruut:"
echo ""
echo "1 - Tartu → Tallinn"
echo "2 - Tartu → Valga"
echo "3 - Tartu → Koidula"
echo "4 - Tallinn → Tartu"
echo "5 - Tapa → Tartu"
echo "6 - Tartu → Tapa"
echo ""
echo -n "Sisesta valik: "
read valik

# 2. Kontrolli kasutaja sisendit
if [ -z "$valik" ]; then
    echo "Valik jäi sisestamata."
    exit 1
fi

# Marsruudi määramine case-lausestikuga
case "$valik" in
    1)
        lahtejaam="Tartu"
        sihtjaam="Tallinn"
        ;;
    2)
        lahtejaam="Tartu"
        sihtjaam="Valga"
        ;;
    3)
        lahtejaam="Tartu"
        sihtjaam="Koidula"
        ;;
    4)
        lahtejaam="Tallinn"
        sihtjaam="Tartu"
        ;;
    5)
        lahtejaam="Tapa"
        sihtjaam="Tartu"
        ;;
    6)
        lahtejaam="Tartu"
        sihtjaam="Tapa"
        ;;
    *)
        echo "Vigane valik."
        exit 1
        ;;
esac

# 3. Küsi andmed Elroni API-st
api_url="https://elron.ee/live-map/stop/$lahtejaam"
api_vastus=$(curl -s "$api_url")

# Kontrolli API päringu õnnestumist
if [ $? -ne 0 ] || [ -z "$api_vastus" ]; then
    echo "Elroni API päring ebaõnnestus."
    exit 1
fi

# 4 & 5. Filtreeri vajalikud rongid sihtjaama järgi
sobivad_rongid=$(echo "$api_vastus" | tr '}' '\n' | grep "\"sihtjaam\":\"$sihtjaam\"")

# 6. Kontrolli, kas sobivaid ronge leiti
if [ -z "$sobivad_rongid" ]; then
    echo "Sobivaid ronge ei leitud."
    exit 1
fi

# 7. Leia rongide väljumisajad
valjumisajad=$(echo "$sobivad_rongid" | grep -o '"plaaniline_aeg":"[0-9]\{2\}:[0-9]\{2\}"' | cut -d '"' -f 4)

# 8. Leia praegune kellaaeg
praegune_aeg=$(date +%H:%M)

# Kuva päis
echo ""
echo "$lahtejaam → $sihtjaam"
echo "Praegune kellaaeg: $praegune_aeg"
echo ""
echo "Väljumised:"
echo ""

# 9 & 10. Kuva KÕIK väljumisajad (awk võrdleb ja värvib iga rida automaatselt)
echo "$valjumisajad" | awk -v praegune="$praegune_aeg" -v red="$PUNANE" -v green="$ROHELINE" -v nc="$NC" '
NF {
    if ($1 < praegune) {
        print red $1 "  rong on juba väljunud" nc
    } else {
        print green $1 "  rong on veel ees" nc
    }
}'
