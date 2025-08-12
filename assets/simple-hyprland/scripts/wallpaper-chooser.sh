#!/bin/bash
# Simple wallpaper chooser for Hyprland using swww

WALLPAPER_DIR="$HOME/.config/swww/wallpapers"

# Colors for output
INFO="\033[34m[INFO]\033[0m"
OK="\033[32m[OK]\033[0m"
ERROR="\033[31m[ERROR]\033[0m"
NOTE="\033[33m[NOTE]\033[0m"

echo -e "${INFO} 🎨 Hyprland Wallpaper Chooser"
echo ""

# Check if swww is running
if ! pgrep -x "swww-daemon" > /dev/null; then
    echo -e "${ERROR} swww-daemon is not running"
    echo -e "${NOTE} Start it with: swww-daemon &"
    exit 1
fi

# Check if wallpaper directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
    echo -e "${ERROR} Wallpaper directory not found: $WALLPAPER_DIR"
    echo -e "${NOTE} Run the installer to create default wallpapers"
    exit 1
fi

# List available wallpapers
echo -e "${INFO} Available wallpapers:"
echo ""

wallpapers=()
i=1

# Find PNG files
for wallpaper in "$WALLPAPER_DIR"/*.png; do
    if [ -f "$wallpaper" ]; then
        basename_wallpaper=$(basename "$wallpaper")
        echo "  $i) $basename_wallpaper"
        wallpapers+=("$wallpaper")
        ((i++))
    fi
done

# Find JPG files
for wallpaper in "$WALLPAPER_DIR"/*.jpg "$WALLPAPER_DIR"/*.jpeg; do
    if [ -f "$wallpaper" ]; then
        basename_wallpaper=$(basename "$wallpaper")
        echo "  $i) $basename_wallpaper"
        wallpapers+=("$wallpaper")
        ((i++))
    fi
done

if [ ${#wallpapers[@]} -eq 0 ]; then
    echo -e "${ERROR} No wallpapers found in $WALLPAPER_DIR"
    echo -e "${NOTE} Add some .png or .jpg files to the wallpapers directory"
    exit 1
fi

echo ""
echo -e "${NOTE} Enter the number of the wallpaper you want to set:"
read -p "Choice (1-$((i-1))): " choice

# Validate input
if ! [[ "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -lt 1 ] || [ "$choice" -ge $i ]; then
    echo -e "${ERROR} Invalid choice: $choice"
    exit 1
fi

# Set wallpaper
selected_wallpaper="${wallpapers[$((choice-1))]}"
echo -e "${INFO} Setting wallpaper: $(basename "$selected_wallpaper")"

if swww img "$selected_wallpaper"; then
    echo -e "${OK} ✅ Wallpaper set successfully!"
    
    # Update the symlink for next boot
    ln -sf "$selected_wallpaper" "$HOME/.config/swww/wall.png"
    echo -e "${NOTE} Wallpaper will be restored on next login"
else
    echo -e "${ERROR} Failed to set wallpaper"
    exit 1
fi

echo ""
echo -e "${NOTE} 💡 Tips:"
echo "  • To add custom wallpapers, copy them to: $WALLPAPER_DIR"
echo "  • To set a wallpaper directly: swww img /path/to/wallpaper.png"
echo "  • To see current wallpaper info: swww query"