#!/bin/bash

for (( arv=1000; arv<=9999; arv++ )); do
    praegune=$arv

    while (( praegune > 9)); do
        numbrite_summa=0
        ajutine=$praegune

        while (( ajutine > 0 )); do
            numbrite_summa=$(( numbrite_summa + ajutine % 10 ))
            ajutine=$(( ajutine / 10 ))                         
        done

        praegune=$numbrite_summa
    done

    if (( praegune == 7 )); then
        echo "$arv"
    fi
done
