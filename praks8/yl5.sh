#!/bin/bash
# Skript kutsub funktsiooni välja tsükli abil mitu korda.

hello() {
    echo "Tere!"
}

# Käivitame funktsiooni tsüklis 5 korda
for i in {1..5}
do
    hello
done
