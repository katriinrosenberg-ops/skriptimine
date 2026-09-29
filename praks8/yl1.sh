#!/bin/bash

tervita() {
    echo "Tere!"
    echo "Tänane kuupäev ja kellaaeg on:"
    TZ="Europe/Tallinn" date "+%d.%m.%Y kell %H:%M:%S"
}

tervita
