#!/bin/bash

if [ -z "${DISCORD_WEBHOOK_URL}" ]; then
    printf 'DISCORD_WEBHOOK_URL is not set\n'
    exit 1
fi

nodes=$(jq 'length' < /srv/http/data.btcmap.org/legacy-nodes.json)

message="We still have $nodes legacy nodes. Help us verify and update them: https://data.btcmap.org/legacy-nodes.html"

curl -H "Content-Type: application/json" -d "{\"username\": \"btcmap.org\", \"content\": \"$message\"}" "${DISCORD_WEBHOOK_URL}"