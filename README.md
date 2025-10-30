# Hyprland Modeline Switcher

> A script to quickly switch between different modelines in Hyprland.

This script, when combined with a keybinding, opens a terminal window to change your modeline (resolution), which is useful for tasks like gaming that require a stretched resolution.

## Installation

First, make sure that you already have a few modelines in your `hyprland.conf` (or similar) config file. It should look something like this:

```bash
monitor = HDMI-A-2, modeline 297.00 1920 2008 2052 2200 1080 1084 1089 1125 +hsync +vsync, auto, 1
#monitor = HDMI-A-2, modeline 299.93 1440 1528 1572 1720 1080 1084 1089 1125 +hsync +vsync, auto, 1
#monitor = HDMI-A-2, modeline 299.45 1280 1360 1404 1560 960 963 968 1005 +hsync +vsync, auto, 1
```

Only the active modeline should be uncommented, or the script will not function correctly. The following examples will use these three resolutions: 1920x1080, 1440x1080, and 1280x960.

Next, clone the repository and open the `modeline_switch.sh` file to configure it. You will need to change the following:

1.  **`CONFIG_FILE`**: Set the path to your Hyprland configuration file (e.g., `~/.config/hypr/hyprland.conf`).
2.  **`MONITOR_NAME`**: Specify the name of the monitor you want to control (e.g., `HDMI-A-2`).
3.  **`MODELINE_PATTERNS`**: Define the unique starting patterns of your modelines. Make sure each pattern is distinct enough to avoid conflicts.
4.  **`MENU_ENTRIES`**: Customize the display names for each modeline in the selection menu.

## Usage Example

You can bind this script to a keybinding, for example, to open it with Kitty:

```bash
bind = SUPER, D, exec, kitty --title "modeline" -e ~/hyprland-modeline/modeline_switch.sh
```

You can also add a few window rules to specify its size and position:

```bash
windowrule = float, title:^(modeline)$
windowrule = size 716 450, title:^(modeline)$
windowrule = center, title:^(modeline)$
```

The ASCII art in the script can be replaced with your own, but you may need to adjust the window size to fit it properly.

This is how it will look:

<img width="716" height="450" alt="image" src="https://github.com/user-attachments/assets/f0c2aefd-1667-49e1-ab62-dfba618a6bc6" />

## Credits

-   **Omarchy** for the logo ([link](https://github.com/basecamp/omarchy)).
