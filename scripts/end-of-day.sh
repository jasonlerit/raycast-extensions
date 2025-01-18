#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title End of Day Note
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 💼

# Documentation:
# @raycast.description Open eod note in neovim
# @raycast.author jason_lerit
# @raycast.authorURL https://raycast.com/jason_lerit

DATE=$(date +%Y-%m-%d)
TIME=$(date +'%I:%M %p')

NOTE_FILE="$HOME/Obsidian Vault/02 - Work/00 - End of Day/$DATE.md"
TEMPLATE_FILE="$HOME/Obsidian Vault/03 - Templates/(TEMPLATE) End of Day.md"

if [ ! -f "$NOTE_FILE" ]; then
    if [ ! -f "$TEMPLATE_FILE" ]; then
        echo "Template file not found."
        exit 1
    fi

    sed "s/{{date}}/$DATE/g; s/{{time}}/$TIME/g" "$TEMPLATE_FILE" > "$NOTE_FILE"
fi

/Applications/WezTerm.app/Contents/MacOS/wezterm -e nvim "$NOTE_FILE" &

sleep 0.2

osascript <<EOD
tell application "System Events"
    -- Ensure WezTerm is the active application
    tell application "WezTerm" to activate
end tell
EOD

echo "End of Day Note opened successfully"
