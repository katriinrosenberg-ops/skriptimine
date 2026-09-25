#!/bin/bash

summa=0

for (( i=1; i<=10; i++ ))
do
    if [ $((i % 2)) -eq 0 ]; then
        summa=$((summa + i))
    fi
done

echo "Arvude vahemikus 1 kuni 10 (kaasaarvutud) paarisarvude summa on: $summa"
