#!/bin/bash

if [ -z "${DISCORD_WEBHOOK_URL}" ]; then
    printf 'DISCORD_WEBHOOK_URL is not set\n'
    exit 1
fi

diff_lines=$(wc -l /srv/http/data.btcmap.org/elements-diff.txt | cut --delimiter=' ' --fields 1)
printf 'Diff lines: %s\n' $diff_lines

if [ "$diff_lines" -gt 0 ]; then
    jq -n --arg msg "$(cat /srv/http/data.btcmap.org/elements-diff.txt)" '{ username: "btcmap.org", content: $msg }' > /tmp/discord-request-body.json
    curl -H "Content-Type: application/json" -d "@/tmp/discord-request-body.json" "$DISCORD_WEBHOOK_URL"
fi