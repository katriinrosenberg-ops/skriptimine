#!/bin/bash

for i in {1..5}
do
	echo "Valine tsukkel: i = $i"

	for j in {1..10}
	do
	    echo "Sisemine tsukkel: j = $j"

	    if [[ $j -eq 5 ]]; then
		echo "Sisemine tsukkel joudis vaartuseni 5, katkestan mõlemad"
		break 2
	    fi
      done
done

echo "Parast tsukleid"
