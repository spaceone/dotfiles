#!/usr/bin/env bash
# foot Keyboard-Selection: lässt dich Text manuell eingeben und in PRIMARY oder CLIPBOARD kopieren

# Zeige Eingabefeld
text=$(wofi --dmenu --prompt "Copy text:")

if [ -n "$text" ]; then
    # Kopiere sowohl in PRIMARY als auch CLIPBOARD
    echo -n "$text" | wl-copy
    echo -n "$text" | wl-copy --primary
fi
