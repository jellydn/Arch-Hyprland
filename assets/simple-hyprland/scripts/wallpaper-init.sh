#!/bin/bash
# Wallpaper initialization script for Hyprland Simple Config

WALLPAPER_DIR="$HOME/.config/swww/wallpapers"
WALLPAPER_LINK="$HOME/.config/swww/wall.png"

# Colors for output
INFO="\033[34m[INFO]\033[0m"
OK="\033[32m[OK]\033[0m"
ERROR="\033[31m[ERROR]\033[0m"
NOTE="\033[33m[NOTE]\033[0m"

# Wait for swww-daemon to be ready
sleep 2

# Check if swww-daemon is running, if not start it
if ! pgrep -x "swww-daemon" > /dev/null; then
    echo -e "${INFO} Starting swww-daemon..."
    swww-daemon --format xrgb &
    sleep 2
fi

# Ensure wallpaper directory exists
mkdir -p "$WALLPAPER_DIR"

# Check if we have a valid wallpaper to set
if [ -L "$WALLPAPER_LINK" ] && [ -f "$WALLPAPER_LINK" ]; then
    # Use the symlinked wallpaper
    wallpaper_path="$(readlink -f "$WALLPAPER_LINK")"
    if [ -f "$wallpaper_path" ] && [ -s "$wallpaper_path" ]; then
        echo -e "${INFO} Setting wallpaper: $(basename "$wallpaper_path")"
        swww img "$wallpaper_path" --transition-type fade --transition-duration 1
        exit 0
    fi
elif [ -f "$HOME/.config/swww/wall.png.missing" ]; then
    echo -e "${NOTE} Fallback marker found, proceeding with color fallback"
    rm -f "$HOME/.config/swww/wall.png.missing" 2>/dev/null || true
fi

# Look for any valid wallpaper in the wallpapers directory
for wallpaper in "$WALLPAPER_DIR"/*.{png,jpg,jpeg} 2>/dev/null; do
    if [ -f "$wallpaper" ] && [ -s "$wallpaper" ]; then
        echo -e "${INFO} Setting default wallpaper: $(basename "$wallpaper")"
        swww img "$wallpaper" --transition-type fade --transition-duration 1
        ln -sf "$wallpaper" "$WALLPAPER_LINK"
        exit 0
    fi
done

# No valid wallpaper found, create a fallback
echo -e "${NOTE} No valid wallpaper found, creating fallback..."
fallback_color="#1e1e2e"  # Catppuccin Mocha background

# Try to create a simple colored background
if command -v convert >/dev/null 2>&1; then
    convert -size 1920x1080 xc:"$fallback_color" "$WALLPAPER_DIR/fallback.png" 2>/dev/null
elif command -v magick >/dev/null 2>&1; then
    magick -size 1920x1080 xc:"$fallback_color" "$WALLPAPER_DIR/fallback.png" 2>/dev/null
else
    # Create a minimal fallback using printf (creates a very small but valid PNG)
    echo -e "${NOTE} ImageMagick not available, using swww's color fill feature"
    # Use swww's built-in color feature as last resort
    swww img - <<< "$(printf '\x89PNG\r\n\x1a\n\x00\x00\x00\rIHDR\x00\x00\x00\x01\x00\x00\x00\x01\x08\x02\x00\x00\x00\x90wS\xde\x00\x00\x00\x0cIDATx\x9cc\x1e\x1e.\x00\x00\x00\x03\x00\x01\x1c\xee\x1c\x9f\x00\x00\x00\x00IEND\xaeB`\x82')" || swww clear "$fallback_color"
    exit 0
fi

# Set the fallback wallpaper if creation was successful
if [ -f "$WALLPAPER_DIR/fallback.png" ] && [ -s "$WALLPAPER_DIR/fallback.png" ]; then
    echo -e "${OK} Setting fallback wallpaper"
    swww img "$WALLPAPER_DIR/fallback.png" --transition-type fade --transition-duration 1
    ln -sf "$WALLPAPER_DIR/fallback.png" "$WALLPAPER_LINK"
else
    # Ultimate fallback: use swww clear with solid color
    echo -e "${NOTE} Using solid color background"
    swww clear "$fallback_color"
fi