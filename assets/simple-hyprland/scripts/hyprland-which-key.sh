#!/bin/bash
# 💫 Hyprland Which-Key Helper 💫 #
# Shows available keybindings for easy discovery

# Color scheme (Catppuccin Mocha)
BACKGROUND="#1e1e2e"
FOREGROUND="#cdd6f4"
PRIMARY="#cba6f7"
SECONDARY="#89b4fa"
SUCCESS="#a6e3a1"
WARNING="#fab387"
ERROR="#f38ba8"

# Function to show main keybinding categories
show_main_menu() {
    rofi -dmenu -i -p "󰌌 Hyprland Which-Key" \
        -theme-str "window { background-color: ${BACKGROUND}; }" \
        -theme-str "textbox { text-color: ${PRIMARY}; }" \
        -theme-str "listview { lines: 12; }" \
        -config ~/.config/hyprland/rofi/config.rasi \
        -markup-rows \
        -format 'i:s' \
        <<< "0:<span color='${SUCCESS}'>󰀻 Applications</span> - App launcher, terminal, browser, file manager
1:<span color='${PRIMARY}'>󱂬 Window Management</span> - Move, resize, close, toggle floating, fullscreen
2:<span color='${SECONDARY}'>󰧨 Workspaces</span> - Switch workspaces, move windows between workspaces
3:<span color='${WARNING}'>󰍉 Tiling Controls</span> - Split direction, swap windows, layout controls
4:<span color='${ERROR}'>󰐥 System</span> - Lock screen, logout menu, reload config
5:<span color='${SUCCESS}'>󰌌 Media & Volume</span> - Volume control, brightness, media keys
6:<span color='${PRIMARY}'>󰹑 Screenshots</span> - Full screen, area selection, clipboard
7:<span color='${SECONDARY}'>󰘳 Special</span> - Special workspace, scratchpad, advanced features"
}

# Function to show application keybindings
show_applications() {
    rofi -dmenu -i -p "󰀻 Applications" \
        -theme-str "window { background-color: ${BACKGROUND}; }" \
        -theme-str "textbox { text-color: ${SUCCESS}; }" \
        -config ~/.config/hyprland/rofi/config.rasi \
        -markup-rows \
        <<< "<span color='${FOREGROUND}'><b>Super + Return</b></span>      Open terminal (current)
<span color='${FOREGROUND}'><b>Super + T</b></span>            Open terminal (current)
<span color='${SUCCESS}'><b>Super + Shift + Return</b></span> Choose terminal (foot/kitty/alacritty/etc)
<span color='${FOREGROUND}'><b>Super + B</b></span>            Open browser (firefox)  
<span color='${FOREGROUND}'><b>Super + W</b></span>            Open browser (firefox)
<span color='${FOREGROUND}'><b>Super + E</b></span>            Open file manager (thunar)
<span color='${FOREGROUND}'><b>Super + D</b></span>            Application launcher (rofi)
<span color='${FOREGROUND}'><b>Super + R</b></span>            Run command (rofi)

<span color='${PRIMARY}'>󰌌 Quick Access:</span>
- Click waybar OS logo for app launcher
- All applications tile by default for productivity"
}

# Function to show window management keybindings
show_window_management() {
    rofi -dmenu -i -p "󱂬 Window Management" \
        -theme-str "window { background-color: ${BACKGROUND}; }" \
        -theme-str "textbox { text-color: ${PRIMARY}; }" \
        -config ~/.config/hyprland/rofi/config.rasi \
        -markup-rows \
        <<< "<span color='${FOREGROUND}'><b>Super + Q</b></span>                Close active window
<span color='${FOREGROUND}'><b>Super + V</b></span>                Toggle floating/tiled
<span color='${FOREGROUND}'><b>Super + F</b></span>                Fullscreen window
<span color='${FOREGROUND}'><b>Super + Shift + F</b></span>        True fullscreen
<span color='${FOREGROUND}'><b>Super + C</b></span>                Center floating window

<span color='${SUCCESS}'>󰁍 Move Focus:</span>
<span color='${FOREGROUND}'><b>Super + ←/→/↑/↓</b></span>       Move focus between windows

<span color='${WARNING}'>󰜈 Move Windows:</span>
<span color='${FOREGROUND}'><b>Super + Shift + ←/→/↑/↓</b></span> Move window in direction

<span color='${ERROR}'>󰩨 Resize Windows:</span>
<span color='${FOREGROUND}'><b>Super + Ctrl + ←/→/↑/↓</b></span>  Resize active window

<span color='${SECONDARY}'>󰐱 Mouse Controls:</span>
<span color='${FOREGROUND}'><b>Super + Mouse1</b></span>          Move window
<span color='${FOREGROUND}'><b>Super + Mouse2</b></span>          Resize window"
}

# Function to show workspace keybindings
show_workspaces() {
    rofi -dmenu -i -p "󰧨 Workspaces" \
        -theme-str "window { background-color: ${BACKGROUND}; }" \
        -theme-str "textbox { text-color: ${SECONDARY}; }" \
        -config ~/.config/hyprland/rofi/config.rasi \
        -markup-rows \
        <<< "<span color='${SUCCESS}'>󰖯 Switch Workspaces:</span>
<span color='${FOREGROUND}'><b>Super + 1-9</b></span>            Switch to workspace 1-9
<span color='${FOREGROUND}'><b>Super + 0</b></span>              Switch to workspace 10
<span color='${FOREGROUND}'><b>Super + Mouse Wheel</b></span>     Scroll through workspaces

<span color='${WARNING}'>󰜸 Move Windows:</span>
<span color='${FOREGROUND}'><b>Super + Shift + 1-9</b></span>     Move window to workspace 1-9
<span color='${FOREGROUND}'><b>Super + Shift + 0</b></span>       Move window to workspace 10

<span color='${PRIMARY}'>󰘳 Special Workspace:</span>
<span color='${FOREGROUND}'><b>Super + \`</b></span>              Toggle special workspace (scratchpad)
<span color='${FOREGROUND}'><b>Super + Shift + \`</b></span>      Move window to special workspace

<span color='${SECONDARY}'>󰍉 Workspace Organization:</span>
- Workspace 1: Terminals
- Workspace 2: Browsers  
- Workspace 3: File managers
- Workspace 4: Code editors"
}

# Function to show tiling controls
show_tiling() {
    rofi -dmenu -i -p "󰍉 Tiling Controls" \
        -theme-str "window { background-color: ${BACKGROUND}; }" \
        -theme-str "textbox { text-color: ${WARNING}; }" \
        -config ~/.config/hyprland/rofi/config.rasi \
        -markup-rows \
        <<< "<span color='${SUCCESS}'>󰜸 Split Controls:</span>
<span color='${FOREGROUND}'><b>Super + J</b></span>              Toggle split direction
<span color='${FOREGROUND}'><b>Super + P</b></span>              Pseudo-tile window
<span color='${FOREGROUND}'><b>Super + S</b></span>              Swap split direction
<span color='${FOREGROUND}'><b>Super + G</b></span>              Toggle split layout

<span color='${PRIMARY}'>󰁍 Window Swapping:</span>
<span color='${FOREGROUND}'><b>Super + Shift + J</b></span>       Swap windows in split

<span color='${WARNING}'>󰖯 Master Layout:</span>
<span color='${FOREGROUND}'><b>Super + I</b></span>              Add window to master
<span color='${FOREGROUND}'><b>Super + O</b></span>              Remove window from master
<span color='${FOREGROUND}'><b>Super + Shift + Return</b></span>  Swap with master window

<span color='${SECONDARY}'>⚙️ Layout Features:</span>
- Smart gaps (removed when only one window)
- Automatic tiling for productivity
- Intelligent split ratios
- Preserve split on window close"
}

# Function to show system controls
show_system() {
    rofi -dmenu -i -p "󰐥 System" \
        -theme-str "window { background-color: ${BACKGROUND}; }" \
        -theme-str "textbox { text-color: ${ERROR}; }" \
        -config ~/.config/hyprland/rofi/config.rasi \
        -markup-rows \
        <<< "<span color='${SUCCESS}'>🔒 Session Control:</span>
<span color='${FOREGROUND}'><b>Super + L</b></span>              Lock screen (hyprlock)
<span color='${FOREGROUND}'><b>Super + Shift + Q</b></span>      Power menu (wlogout)
<span color='${FOREGROUND}'><b>Super + M</b></span>              Exit Hyprland
<span color='${FOREGROUND}'><b>Super + Shift + R</b></span>      Reload Hyprland config
<span color='${SUCCESS}'><b>Super + Shift + W</b></span>      Restart waybar (if missing)

<span color='${WARNING}'>🚪 Power Menu Actions:</span>
- <b>L</b> - Lock screen
- <b>E</b> - Logout  
- <b>S</b> - Shutdown
- <b>R</b> - Reboot
- <b>U</b> - Suspend

<span color='${PRIMARY}'>󰍹 Notifications:</span>
<span color='${FOREGROUND}'><b>Super + N</b></span>              Toggle notification center

<span color='${SECONDARY}'>💡 Quick Access:</span>
- Click waybar power button for power menu
- Right-click waybar network for settings"
}

# Function to show media and volume controls
show_media() {
    rofi -dmenu -i -p "󰌌 Media & Volume" \
        -theme-str "window { background-color: ${BACKGROUND}; }" \
        -theme-str "textbox { text-color: ${SUCCESS}; }" \
        -config ~/.config/hyprland/rofi/config.rasi \
        -markup-rows \
        <<< "<span color='${SUCCESS}'>🔊 Volume Control:</span>
<span color='${FOREGROUND}'><b>Volume Up</b></span>             Increase volume +5%
<span color='${FOREGROUND}'><b>Volume Down</b></span>           Decrease volume -5%
<span color='${FOREGROUND}'><b>Volume Mute</b></span>           Toggle mute
<span color='${FOREGROUND}'><b>Waybar Volume Click</b></span>    Open pavucontrol
<span color='${FOREGROUND}'><b>Waybar Volume Scroll</b></span>   Adjust volume

<span color='${PRIMARY}'>🎵 Media Control:</span>
<span color='${FOREGROUND}'><b>Play/Pause</b></span>            Play/pause media
<span color='${FOREGROUND}'><b>Next Track</b></span>            Next media track
<span color='${FOREGROUND}'><b>Previous Track</b></span>        Previous media track

<span color='${WARNING}'>☀️ Brightness:</span>
<span color='${FOREGROUND}'><b>Brightness Up</b></span>         Increase brightness +10%
<span color='${FOREGROUND}'><b>Brightness Down</b></span>       Decrease brightness -10%

<span color='${SECONDARY}'>🎛️ Quick Access:</span>
- Scroll on waybar volume for quick adjustment
- All media keys work with any media player"
}

# Function to show screenshot controls
show_screenshots() {
    rofi -dmenu -i -p "󰹑 Screenshots" \
        -theme-str "window { background-color: ${BACKGROUND}; }" \
        -theme-str "textbox { text-color: ${PRIMARY}; }" \
        -config ~/.config/hyprland/rofi/config.rasi \
        -markup-rows \
        <<< "<span color='${SUCCESS}'>📸 Screenshot Modes:</span>
<span color='${FOREGROUND}'><b>Print Screen</b></span>           Full screen to clipboard
<span color='${FOREGROUND}'><b>Super + Print</b></span>          Area selection to clipboard
<span color='${FOREGROUND}'><b>Super + Shift + S</b></span>      Area selection to clipboard

<span color='${PRIMARY}'>🖼️ Tools Used:</span>
- <b>grim</b> - Screenshot capture
- <b>slurp</b> - Area selection  
- <b>wl-copy</b> - Clipboard management

<span color='${WARNING}'>💡 Usage Tips:</span>
- Screenshots automatically copy to clipboard
- Use any image viewer to see clipboard content
- Area selection shows crosshair cursor"
}

# Function to show special features
show_special() {
    rofi -dmenu -i -p "󰘳 Special Features" \
        -theme-str "window { background-color: ${BACKGROUND}; }" \
        -theme-str "textbox { text-color: ${SECONDARY}; }" \
        -config ~/.config/hyprland/rofi/config.rasi \
        -markup-rows \
        <<< "<span color='${SUCCESS}'>🔧 VM Features:</span>
- Auto-scaling for VMware/VirtualBox/UTM
- VM-optimized animations and effects
- Hardware cursor disabled for stability
- Software rendering when needed

<span color='${PRIMARY}'>⚡ Performance:</span>
- Reduced animations for VM performance
- Optimized blur effects
- Smart resource usage
- Fast startup and reload

<span color='${WARNING}'>🎨 Customization:</span>
- Edit ~/.config/hyprland/hyprland.conf
- Catppuccin Mocha color scheme
- VM-friendly emoji icons in wlogout
- Modular configuration structure

<span color='${SECONDARY}'>🆘 Help:</span>
<span color='${FOREGROUND}'><b>Super + ?</b></span>              Show this which-key menu
- All configs in ~/.config/hyprland/
- Reload with Super + Shift + R
- Logs in ~/Install-Logs/"
}

# Main logic
case "${1:-main}" in
    "0") show_applications ;;
    "1") show_window_management ;;
    "2") show_workspaces ;;
    "3") show_tiling ;;
    "4") show_system ;;
    "5") show_media ;;
    "6") show_screenshots ;;
    "7") show_special ;;
    *) 
        selection=$(show_main_menu)
        if [[ -n "$selection" ]]; then
            # Extract the number before the colon
            category=$(echo "$selection" | cut -d: -f1)
            exec "$0" "$category"
        fi
        ;;
esac