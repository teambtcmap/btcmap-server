#!/bin/bash

echo '<!DOCTYPE html>'
echo '<html lang="en">'
echo '<body>'
echo '<ol>'
jq -r '.[] | ("<li><a href=\"" + (.edit_link | tostring) + "\">" + .name + "</a></li>")' < $1
echo '</ol>'
echo '</body>'
