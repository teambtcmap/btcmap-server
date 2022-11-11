#!/bin/bash

file_name=$(date --rfc-3339=seconds | sed 's/ /T/')

sqlite3 '/root/.local/share/btcmap/btcmap.db' ".backup /root/.local/share/btcmap/backup/${file_name}.db"