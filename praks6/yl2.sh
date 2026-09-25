#!/bin/bash

read -p "Sisesta suvaline täisarv: " arv

temp=$arv
summa=0

is_negative=0
if [ $temp -lt 0 ]; then
    is_negative=1
    temp=$((temp * -1))
fi

while [ $temp -gt 0 ]
do
    jaak=$((temp % 10))
    summa=$((summa + jaak))
    temp=$((temp / 10))
done

if [ $is_negative -eq 1 ]; then
    summa=$((summa * -1))
fi

echo "Arvu $arv numbrite summa on $summa"
