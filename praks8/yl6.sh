#!/bin/bash
# Skript näitab, kuidas funktsioon saab kutsuda teisi funktsioone.

show_user() {
    echo "Kasutaja:"
    whoami
}

show_host() {
    echo "Arvuti:"
    hostname
}

show_system() {
    show_user
    show_host
}

# Peafunktsiooni väljakutse
show_system
