#!/bin/bash

cat $1 | xq '[.kml.Document.Folder[].Placemark[] | {name, gps: .Point.coordinates} | select(.gps != null)] | map(.gps |= split(","))' | jq '[.[] | { name, lat: .gps[1], lon: .gps[0], edit_link: ("https://www.openstreetmap.org/edit#map=20" + "/" + .gps[1] + "/" + .gps[0]) }]'
