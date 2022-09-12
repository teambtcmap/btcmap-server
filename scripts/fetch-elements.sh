#!/bin/bash

curl --location --output /tmp/elements.json 'https://github.com/teambtcmap/btcmap-data/raw/main/data.json'

cd /srv/http/data.btcmap.org

diff -u elements.json /tmp/elements.json > elements-diff.txt

cp /tmp/elements.json elements.json
cp elements.json data.json
cp elements.json places.json

rm /tmp/elements.json

DISCORD_WEBHOOK_URL={{ discord_webhook_url }} report-elements-diff

generate-legacy-nodes