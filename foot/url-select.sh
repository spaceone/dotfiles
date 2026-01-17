#!/usr/bin/env bash
# foot URL-Selection script
# Markiert URLs im Terminal und öffnet sie in Firefox

# Abfrage der aktuellen Selection (PRIMARY)
selection=$(wl-paste --primary)

# Regex für URLs
url=$(echo "$selection" | grep -oE 'https?://[^ ]+')

if [ -n "$url" ]; then
    # Öffne URL in Firefox
    firefox "$url" &
else
    notify-send "foot: No URL found in selection"
fi
