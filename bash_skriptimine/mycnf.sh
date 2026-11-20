#!/bin/bash
#
# Skript MySQL kliendi konfiguratsioonifaili (.my.cnf) loomiseks
#
# Loome kasutaja kodukausta peidetud faili .my.cnf sisselogimisandmetega
cat >"$HOME/.my.cnf" <<'EOF'
[client]
host=localhost
user=root
password=qwerty
EOF

# Määrame failile turvalised õigused (ainult omanik saab lugeda ja kirjutada)
chmod 600 "$HOME/.my.cnf"
