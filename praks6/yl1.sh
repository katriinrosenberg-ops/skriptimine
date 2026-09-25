#!/bin/bash

for i in {1..10}
do
    if [[ $i -eq 7 ]]; then
	echo "Katkestan tsukli, kuna i=7"
	break
    fi
    echo "i = $i"
done
