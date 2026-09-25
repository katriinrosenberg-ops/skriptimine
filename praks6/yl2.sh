#!/bin/bash

while true
do
    read -p "Sisesta number (0, et lopetada): " number

    if [[ $number -eq 0 ]]; then
	echo "Lopetan"
	break
    fi

    if [[ $number -lt 0 ]]; then
	echo "Negatiivne number, jatan vahele"
	continue
    fi

    echo "Sisestasid: $number"
done
