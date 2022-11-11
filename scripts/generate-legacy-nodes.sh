#!/bin/bash

curl -s https://api.btcmap.org/v2/elements | jq '[.[] | { id: .osm_json.id, type: .osm_json.type, name: .osm_json.tags.name, legacy: .osm_json.tags."payment:bitcoin", deleted_at: .deleted_at } | select(.type | test("node")) | select(.legacy | test("yes")?) | select(.deleted_at == "") + {"edit_link":("https://www.openstreetmap.org/edit?node=" + (.id | tostring))}]' > /srv/http/data.btcmap.org/legacy-nodes.json

html=/srv/http/data.btcmap.org/legacy-nodes.html
echo '<!DOCTYPE html>' > $html
echo '<html lang="en">' >> $html
echo '<body>' >> $html
echo '<ol>' >> $html
jq -r '.[] | ("<li><a href=\"" + (.edit_link | tostring) + "\">" + .name + "</a></li>")' < /srv/http/data.btcmap.org/legacy-nodes.json >> $html
echo '</ol>' >> $html
echo '</body>' >> $html