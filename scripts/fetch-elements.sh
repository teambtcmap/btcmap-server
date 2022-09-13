#!/bin/bash

DISCORD_WEBHOOK_URL={{ discord_webhook_url }}

if [ -z "${DISCORD_WEBHOOK_URL}" ]; then
    printf 'DISCORD_WEBHOOK_URL is not set\n'
    exit 1
fi

curl --location --output /tmp/elements.json 'https://github.com/teambtcmap/btcmap-data/raw/main/data.json'

cd /srv/http/data.btcmap.org

diff -u elements.json /tmp/elements.json > elements-diff.txt
diff_file_name=elements-diff-$(date +%s).txt
diff -u elements.json /tmp/elements.json > $diff_file_name

diff_lines=$(wc -l $diff_file_name | cut --delimiter=' ' --fields 1)
printf 'Diff lines: %s\n' $diff_lines

if [ "$diff_lines" -gt 0 ]; then
    message="New ${diff_lines}-line diff is available at https://data.btcmap.org/${diff_file_name}"
    curl -H "Content-Type: application/json" -d "{\"username\": \"btcmap.org\", \"content\": \"$message\"}" "${DISCORD_WEBHOOK_URL}"
fi

cp /tmp/elements.json elements.json
cp elements.json data.json
cp elements.json places.json

rm /tmp/elements.json

generate-legacy-nodes