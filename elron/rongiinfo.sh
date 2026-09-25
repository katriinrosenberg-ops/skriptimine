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
echo ""
echo -n "Sisesta valik: "
read valik

# 2. Kontrolli kasutaja sisendit (tühjuse kontroll)
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
    *)
        echo "Vigane valik."
        exit 1
        ;;
esac

# 3. Küsi andmed Elroni API-st curl käsu abil
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

# Kuva päis vastavalt juhendile
echo ""
echo "$lahtejaam → $sihtjaam"
echo "Praegune kellaaeg: $praegune_aeg"
echo ""
echo "Väljumised:"
echo ""

# 9 & 10. Kontrolli ja kuva iga väljumisaeg eraldi ilma tsükliteta
aeg1=$(echo "$valjumisajad" | sed -n '1p')
aeg2=$(echo "$valjumisajad" | sed -n '2p')
aeg3=$(echo "$valjumisajad" | sed -n '3p')
aeg4=$(echo "$valjumisajad" | sed -n '4p')
aeg5=$(echo "$valjumisajad" | sed -n '5p')

if [ -n "$aeg1" ]; then
    if [[ "$aeg1" < "$praegune_aeg" ]]; then
        echo -e "${PUNANE}$aeg1  rong on juba väljunud${NC}"
    else
        echo -e "${ROHELINE}$aeg1  rong on veel ees${NC}"
    fi
fi

if [ -n "$aeg2" ]; then
    if [[ "$aeg2" < "$praegune_aeg" ]]; then
        echo -e "${PUNANE}$aeg2  rong on juba väljunud${NC}"
    else
        echo -e "${ROHELINE}$aeg2  rong on veel ees${NC}"
    fi
fi

if [ -n "$aeg3" ]; then
    if [[ "$aeg3" < "$praegune_aeg" ]]; then
        echo -e "${PUNANE}$aeg3  rong on juba väljunud${NC}"
    else
        echo -e "${ROHELINE}$aeg3  rong on veel ees${NC}"
    fi
fi

if [ -n "$aeg4" ]; then
    if [[ "$aeg4" < "$praegune_aeg" ]]; then
        echo -e "${PUNANE}$aeg4  rong on juba väljunud${NC}"
    else
        echo -e "${ROHELINE}$aeg4  rong on veel ees${NC}"
    fi
fi

if [ -n "$aeg5" ]; then
    if [[ "$aeg5" < "$praegune_aeg" ]]; then
        echo -e "${PUNANE}$aeg5  rong on juba väljunud${NC}"
    else
        echo -e "${ROHELINE}$aeg5  rong on veel ees${NC}"
    fi
fi

