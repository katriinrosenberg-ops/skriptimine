#!/bin/bash

for (( arv=1; arv<=20; arv++ ))
do
    if [ $arv -lt 2 ]; then
        echo "$arv - ei ole algarv"
        continue
    fi

    jagaja=2

    while [ $((arv % jagaja)) -ne 0 ]
    do
        jagaja=$((jagaja + 1))
    done

    if [ $jagaja -eq $arv ]; then
        echo "$arv - on algarv"
    else
        echo "$arv - ei ole algarv"
    fi
done
