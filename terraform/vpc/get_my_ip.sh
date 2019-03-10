#!/bin/sh
IP=$(curl "ifconfig.me")
JSON_STRING=$( jq -n --arg ip "$IP" \
            '{ip: $ip}' )
echo $JSON_STRING