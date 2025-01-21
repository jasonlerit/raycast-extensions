#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Quick Note
# @raycast.mode compact

# Optional parameters:
# @raycast.icon ⚡

# Documentation:
# @raycast.description Open quick note in neovim
# @raycast.author jason_lerit
# @raycast.authorURL https://raycast.com/jason_lerit

DATE=$(date +%Y-%m-%d)
FORMATTED_DATE=$(date "+%A | %B %d, %Y")
TIME=$(date +'%I:%M %p')

NOTE_FILE="$HOME/ObsidianVault/00 - Quick Notes/$DATE.md"
TEMPLATE_FILE="$HOME/ObsidianVault/Templates/Quick Note.md"

if [ ! -f "$NOTE_FILE" ]; then
    if [ ! -f "$TEMPLATE_FILE" ]; then
        echo "Template file not found."
        exit 1
    fi

    sed "s/{{date}}/$FORMATTED_DATE/g; s/{{time}}/$TIME/g" "$TEMPLATE_FILE" > "$NOTE_FILE"
fi

/Applications/WezTerm.app/Contents/MacOS/wezterm -e nvim "$NOTE_FILE" &

sleep 0.2

osascript <<EOD
tell application "System Events"
    -- Ensure WezTerm is the active application
    tell application "WezTerm" to activate
end tell
EOD

echo "Quick Note opened successfully"
