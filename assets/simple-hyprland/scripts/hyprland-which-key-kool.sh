#!/bin/bash
# /* ---- 💫 KooL Which-Key Helper (Performance Optimized) 💫 ---- */
# Based on JaKooLit's KeyHints with rofi interface and VM optimizations

# Check if rofi is already running and kill it
if pidof rofi > /dev/null; then
    pkill rofi
    exit 0
fi

# Create temp file with keybinding categories
temp_file=$(mktemp)

# Main categories menu
cat << EOF > "$temp_file"
📱 Applications
🪟 Window Management  
📊 Workspaces
🔧 Tiling Controls
⚙️  System Controls
🎵 Media & Volume
📸 Screenshots
✨ Special Features
EOF

# Function to show category details
show_category() {
    local category="$1"
    local temp_detail=$(mktemp)
    
    case "$category" in
        "📱 Applications")
            cat << EOF > "$temp_detail"
󰆍 Super + Return → Open Terminal (foot)
󰞷 Super + Shift + Return → Terminal Chooser
󰈹 Super + B → Open Browser (firefox)
󰉋 Super + E → Open File Manager (thunar)
󱓞 Super + D → Application Launcher (rofi)
󰆍 Super + R → Run Command (rofi)
󰌌 Super + / → Show This Help
EOF
            ;;
        "🪟 Window Management")
            cat << EOF > "$temp_detail"
❌ Super + Q → Close Window
🎯 Super + V → Toggle Floating/Tiled
📺 Super + F → Toggle Fullscreen
🔄 Super + J → Toggle Split Direction
🎯 Super + P → Toggle Pseudo (dwindle)
⬅️ Super + Left/Right/Up/Down → Move Focus
🔀 Super + Shift + Arrows → Move Window
📏 Super + Ctrl + Arrows → Resize Window
EOF
            ;;
        "📊 Workspaces")
            cat << EOF > "$temp_detail"
1️⃣ Super + 1-9 → Switch to Workspace
📦 Super + Shift + 1-9 → Move Window to Workspace
✨ Super + S → Toggle Special Workspace
📤 Super + Shift + S → Move to Special Workspace
🔄 Super + Mouse Scroll → Switch Workspaces
🎯 Click Waybar Workspace → Direct Switch
EOF
            ;;
        "🔧 Tiling Controls")
            cat << EOF > "$temp_detail"
🔄 Super + J → Toggle Split Direction
🎭 Super + Shift + Return → Swap with Master
⬅️ Super + H → Focus Left in Stack
➡️ Super + L → Focus Right in Stack
⬆️ Super + K → Focus Up in Stack
⬇️ Super + J → Focus Down in Stack
📐 Drag Window Border → Manual Resize
🎯 Super + Mouse → Move Window
EOF
            ;;
        "⚙️  System Controls")
            cat << EOF > "$temp_detail"
🔒 Super + L → Lock Screen (hyprlock)
🚪 Super + Shift + Q → Logout Menu (wlogout)
🔄 Super + Shift + R → Reload Hyprland
📊 Super + Shift + W → Restart Waybar
🔔 Super + N → Notification Center
🔌 Super + M → Exit Hyprland
🎨 Alt + Tab → Window Switcher
EOF
            ;;
        "🎵 Media & Volume")
            cat << EOF > "$temp_detail"
🔊 Volume Up/Down → Adjust Volume
🔇 Volume Mute → Toggle Audio Mute
🎤 Mic Mute → Toggle Microphone
⏯️ Media Play/Pause → Media Control
⏭️ Media Next/Previous → Skip Tracks
🔆 Brightness Up/Down → Screen Brightness
🎵 Click Volume in Waybar → Open pavucontrol
📊 Scroll Volume in Waybar → Quick Adjust
EOF
            ;;
        "📸 Screenshots")
            cat << EOF > "$temp_detail"
📷 Print Screen → Full Screen Screenshot
📱 Super + Shift + S → Area Selection
📋 Auto Copy → Screenshots to Clipboard
📁 Save Location → ~/Pictures/Screenshots
🖼️ grim → Screenshot Backend
✂️ slurp → Area Selection Tool
🎯 Click & Drag → Select Custom Area
EOF
            ;;
        "✨ Special Features")
            cat << EOF > "$temp_detail"
🖥️ VM Auto-scaling → Detects VMware/VBox
🎨 Catppuccin Mocha → Color Scheme
🚫 No Animations → Performance Mode
📱 Fish Shell → User-friendly Terminal
⚡ Foot Terminal → Fast & Lightweight
🎯 Workspace Names → Auto Organization
💫 KooL Styling → Beautiful Interface
🔧 Which-Key → This Help System
EOF
            ;;
    esac
    
    # Show category details
    rofi -dmenu \
        -i \
        -p "  $category" \
        -theme ~/.config/rofi/kool-style.rasi \
        -markup-rows \
        -width 60 \
        -lines 15 \
        -location 0 \
        -no-custom < "$temp_detail"
    
    rm -f "$temp_detail"
}

# Show main menu and get selection
selected=$(rofi -dmenu \
    -i \
    -p "󰌌 KooL Which-Key Helper" \
    -theme ~/.config/rofi/kool-style.rasi \
    -markup-rows \
    -width 35 \
    -lines 8 \
    -location 0 \
    -no-custom < "$temp_file")

# Clean up temp file
rm -f "$temp_file"

# Show selected category or exit
if [[ -n "$selected" ]]; then
    # Debug: log the selection
    echo "Selected: $selected" >> /tmp/which-key-debug.log
    show_category "$selected"
else
    echo "No selection made" >> /tmp/which-key-debug.log
fi

exit 0