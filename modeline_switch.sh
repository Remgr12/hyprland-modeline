#!/bin/bash

# A script to switch between different modelines for a specific monitor in Hyprland.

# --- User Configuration ---
# Set the path to your Hyprland monitor config file here
CONFIG_FILE="$HOME/.config/hypr/hyprland.conf"

# Define the monitor name
MONITOR_NAME="HDMI-A-2"

# Define the modeline patterns and their corresponding menu entries
MODELINE_PATTERNS=(
    "modeline 297.00 1920"
    "modeline 299.93 1440"
    "modeline 299.45 1280"
    # Add more modeline patterns here
)

MENU_ENTRIES=(
    "1920x1080"
    "1440x1080"
    "1280x960"
    # Add more menu entries here
)

# --- Check if the config file exists ---
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: Configuration file not found at '$CONFIG_FILE'"
    exit 1
fi

# --- Define the multi-line text for the logo ---
read -r -d '' LOGO_ART << "EOF"
██████████████████████████████████████████████████████
██████████████████████████████████████████████████████
████                     ████                     ████
████                     ████                     ████
████    █████████████████████         ████████    ████
████    █████████████████████         ████████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████████████                              ████    ████
████████████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ████                              ████    ████
████    ██████████████████████████████████████    ████
████    ██████████████████████████████████████    ████
████                     ████                     ████
████                     ████                     ████
█████████████████████████████     ████████████████████
█████████████████████████████     ████████████████████
EOF

# --- Generate the menu text ---
MENU_TEXT="\nSelect a modeline for monitor $MONITOR_NAME:\n"
for i in "${!MENU_ENTRIES[@]}"; do
    MENU_TEXT+="  $(($i + 1))) ${MENU_ENTRIES[$i]}\n"
done

# --- Main Script Logic ---
clear

mapfile -t logo_lines <<< "$LOGO_ART"
mapfile -t menu_lines <<< "$MENU_TEXT"

num_logo_lines=${#logo_lines[@]}
num_menu_lines=${#menu_lines[@]}
max_lines=$(( num_logo_lines > num_menu_lines ? num_logo_lines : num_menu_lines ))

for ((i=0; i<max_lines; i++)); do
    menu_part="${menu_lines[i]:-}"
    logo_part="${logo_lines[i]:-}"
    
    printf "  %-40s %s\n" "$menu_part" "$logo_part"
done

# --- Display the prompt and get user input ---
read -p "Enter your choice (1-${#MODELINE_PATTERNS[@]}): " choice

# --- Process the choice ---
if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "${#MODELINE_PATTERNS[@]}" ]; then
    TARGET_PATTERN="${MODELINE_PATTERNS[$(($choice - 1))]}"
else
    echo "Invalid choice. Exiting."
    exit 1
fi

sed -i -E "s/^(monitor = $MONITOR_NAME, modeline.*)/#\1/" "$CONFIG_FILE"
sed -i -E "s/^#(monitor = $MONITOR_NAME, .*$TARGET_PATTERN.*)/\1/" "$CONFIG_FILE"

hyprctl reload

echo "Configuration updated in '$CONFIG_FILE'."
