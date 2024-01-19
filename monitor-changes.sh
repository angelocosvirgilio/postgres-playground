#!/bin/bash

# Imposta il percorso del file da monitorare
FILE_TO_MONITOR="query-editor.sql"

# Calcola l'MD5 iniziale del file
md5_initial=$(md5sum "$FILE_TO_MONITOR" | awk '{print $1}')

while true; do
    # Calcola l'MD5 attuale del file
    md5_current=$(md5sum "$FILE_TO_MONITOR" | awk '{print $1}')

    # Confronta l'MD5 iniziale con l'MD5 attuale
    if [ "$md5_current" != "$md5_initial" ]; then
        # Esegui il comando quando il file cambia
        make query-editor

        # Aggiorna l'MD5 iniziale
        md5_initial="$md5_current"
    fi

    # Attendi prima di controllare di nuovo
    sleep 1
done