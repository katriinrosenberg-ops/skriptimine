#!/bin/bash
# Skript näitab, et funktsioon peab olema defineeritud enne väljakutset.

# Funktsiooni defineerimine (peab olema alguses)
hello() {
    echo "Hello! Funktsioon toimib, sest see on defineeritud enne väljakutsumist."
}

# Funktsiooni käivitamine
hello
