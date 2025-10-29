#!/bin/bash

# A script to switch between different modelines for a specific monitor in Hyprland.

# --- IMPORTANT ---
# SET THE PATH TO YOUR HYPRLAND MONITOR CONFIG FILE HERE
CONFIG_FILE="$HOME/.config/hypr/hyprland.conf"

# --- Check if the config file exists ---
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: Configuration file not found at '$CONFIG_FILE'"
    exit 1
fi

# --- Define modeline patterns ---
MODELINE_1_PATTERN="modeline 297.00 1920" 
MODELINE_2_PATTERN="modeline 299.93 1440" 
MODELINE_3_PATTERN="modeline 299.45 1280"
# MODELINE_4_PATTERN="modeline x x"
# MODELINE_5_PATTERN="modeline x x" 
# MODELINE_6_PATTERN="modeline x x"

# --- Define the multi-line text for the logo and the menu ---
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

read -r -d '' MENU_TEXT << "EOF"

Select a modeline for monitor HDMI-A-2:
  1) 1920x1080
  2) 1440x1080
  3) 1280x960
# 4) xyz
# 5) xyz
# 6) xyz

EOF

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
read -p "Enter your choice (1-3): " choice

# --- Process the choice ---
case $choice in
    1)
        TARGET_PATTERN=$MODELINE_1_PATTERN
        ;;
    2)
        TARGET_PATTERN=$MODELINE_2_PATTERN
        ;;
    3)
        TARGET_PATTERN=$MODELINE_3_PATTERN
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

sed -i -E "s/^(monitor = HDMI-A-2, modeline.*)/#\1/" "$CONFIG_FILE"

sed -i -E "s/^#(monitor = HDMI-A-2, .*$TARGET_PATTERN.*)/\1/" "$CONFIG_FILE"

hyprctl reload

echo "Configuration updated in '$CONFIG_FILE'."
