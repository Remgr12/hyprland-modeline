# Hyprland-modeline
> Script to quickly change modeline.

This is a scipt which when combined with a keybind would open a window to change your modeline (resolution) for example when playing video games and needing a strechted resolution.

## Installation

Fistly make sure that you already have a few modelines in your hyprland.conf (or similar) config. Something along the lines of this

```bash
monitor = HDMI-A-2, modeline 297.00 1920 2008 2052 2200 1080 1084 1089 1125 +hsync +vsync, auto, 1
#monitor = HDMI-A-2, modeline 299.93 1440 1528 1572 1720 1080 1084 1089 1125 +hsync +vsync, auto, 1
#monitor = HDMI-A-2, modeline 299.45 1280 1360 1404 1560 960 963 968 1005 +hsync +vsync, auto, 1
```

Only the active one should be uncommented or else it'll kind of trip all over itself. From here on forward the example will always be these 3 resolutions (1920x1080;1440x1080;1280x960)

Then after you made sure of the first step clone the repo and then open up the .sh file. A few things need to be changed:
1. Change the path of the CONFIG_FILE in the seventh line if your modelines' location differs
2. In lines 16-18 the first few words/numbers (?) of the modelines need to be defined. Make sure that you specify so long so that they're not identical anymore to each other.
3. In lines 53-55 you should change the resolutions to the ones you have (eg. 1920x1080;2560x1440) 
4. Should you have more than three modelines I added three extra commented out entries which should be enough for the majority of people.

## Usage example

You would bind this script to a keybing; eg. for opening it with kitty

```bash
bind = SUPER, D, exec, kitty --title "modeline" -e ~/hyprland-modeline/modeline_switch.sh
```

It could also be given a few windowrules to specifise the size of it

```bash
windowrule = float, title:^(modeline)$
windowrule = size 716 450, title:^(modeline)$ # 716 is the width, 450 the height 
windowrule = center, title:^(modeline)$
```

The art from lines 25-50 could also be changed to whatever ascii art you have laying around but the width and heigth of the window should be changed appropriately, or else the script won't function.

This is how it would approximately look:


## Credits

1. Omarchy for the logo (https://github.com/basecamp/omarchy)
