#!/bin/bash
# Skript näitab mitme argumendi kasutamist funktsioonis.

kasutaja_info() {
    echo "Nimi: $1"
    echo "Vanus: $2"
}

liida() {
    echo $(($1 + $2))
}

# Funktsioonide väljakutsed
kasutaja_info "Mari" 18
echo -n "Arvude 10 ja 5 summa on: "
liida 10 5
