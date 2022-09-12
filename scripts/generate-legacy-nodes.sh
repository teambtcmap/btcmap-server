#!/bin/bash

jq '[.elements[] | { id, type, name: .tags.name, legacy: .tags."payment:bitcoin" } | select(.type | test("node")) | select(.legacy | test("yes")?) + {"edit_link":("https://www.openstreetmap.org/edit?node=" + (.id | tostring))}]' < /srv/http/data.btcmap.org/elements.json > /srv/http/data.btcmap.org/legacy-nodes.json

html=/srv/http/data.btcmap.org/legacy-nodes.html
echo '<!DOCTYPE html>' > $html
echo '<html lang="en">' >> $html
echo '<body>' >> $html
echo '<ol>' >> $html
jq -r '.[] | ("<li><a href=\"" + (.edit_link | tostring) + "\">" + .name + "</a></li>")' < /srv/http/data.btcmap.org/legacy-nodes.json >> $html
echo '</ol>' >> $html
echo '</body>' >> $html