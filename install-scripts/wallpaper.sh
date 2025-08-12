#!/bin/bash
# 💫 https://github.com/jellydn/Arch-Hyprland 💫 #
# Wallpaper system installer and manager for Simple Hyprland Config #

## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change the working directory to the parent directory of the script
PARENT_DIR="$SCRIPT_DIR/.."
cd "$PARENT_DIR" || { echo "${ERROR} Failed to change directory to $PARENT_DIR"; exit 1; }

# Source the global functions script
if ! source "$(dirname "$(readlink -f "$0")")/Global_functions.sh"; then
  echo "Failed to source Global_functions.sh"
  exit 1
fi

# Set the name of the log file to include the current date and time
LOG="Install-Logs/install-$(date +%d-%H%M%S)_wallpaper.log"

printf "\n%s - Installing ${SKY_BLUE}Wallpaper System${RESET} .... \n" "${NOTE}"

# Check if swww is installed
if ! command -v swww >/dev/null 2>&1; then
    echo "${ERROR} swww is not installed! Please install it first:" 2>&1 | tee -a "$LOG"
    echo "  yay -S swww" 2>&1 | tee -a "$LOG"
    exit 1
fi

# Create necessary directories
echo "${INFO} Setting up wallpaper system directories..." 2>&1 | tee -a "$LOG"
mkdir -p "$HOME/.config/swww/wallpapers"
mkdir -p "$HOME/.config/hypr/scripts"

# Copy wallpaper creation script
if [ -f "assets/simple-hyprland/wallpapers/create-defaults.sh" ]; then
    echo "${INFO} Installing wallpaper creation script..." 2>&1 | tee -a "$LOG"
    cp "assets/simple-hyprland/wallpapers/create-defaults.sh" "$HOME/.config/swww/"
    chmod +x "$HOME/.config/swww/create-defaults.sh"
else
    echo "${ERROR} Wallpaper creation script not found!" 2>&1 | tee -a "$LOG"
    exit 1
fi

# Copy wallpaper chooser script
if [ -f "assets/simple-hyprland/scripts/wallpaper-chooser.sh" ]; then
    echo "${INFO} Installing wallpaper chooser script..." 2>&1 | tee -a "$LOG"
    cp "assets/simple-hyprland/scripts/wallpaper-chooser.sh" "$HOME/.config/hypr/scripts/"
    chmod +x "$HOME/.config/hypr/scripts/wallpaper-chooser.sh"
else
    echo "${ERROR} Wallpaper chooser script not found!" 2>&1 | tee -a "$LOG"
    exit 1
fi

# Copy wallpaper initialization script
if [ -f "assets/simple-hyprland/scripts/wallpaper-init.sh" ]; then
    echo "${INFO} Installing wallpaper initialization script..." 2>&1 | tee -a "$LOG"
    cp "assets/simple-hyprland/scripts/wallpaper-init.sh" "$HOME/.config/hypr/scripts/"
    chmod +x "$HOME/.config/hypr/scripts/wallpaper-init.sh"
else
    echo "${ERROR} Wallpaper initialization script not found!" 2>&1 | tee -a "$LOG"
    exit 1
fi

# Create default wallpapers
echo "${INFO} Creating default wallpapers..." 2>&1 | tee -a "$LOG"
cd "$HOME/.config/swww" && ./create-defaults.sh 2>&1 | tee -a "$LOG" || {
    echo "${NOTE} Could not create wallpapers with ImageMagick, creating basic fallback..." 2>&1 | tee -a "$LOG"
    # Fallback: create a simple wallpaper file as placeholder
    mkdir -p "$HOME/.config/swww/wallpapers"
    touch "$HOME/.config/swww/wallpapers/default.png"
    ln -sf "$HOME/.config/swww/wallpapers/default.png" "$HOME/.config/swww/wall.png"
}
cd "$PARENT_DIR"

echo "${OK} Wallpaper system installed successfully!" 2>&1 | tee -a "$LOG"
echo "${INFO} Features installed:" 2>&1 | tee -a "$LOG"
echo "  - 🎨 Default wallpaper collection" 2>&1 | tee -a "$LOG"
echo "  - 🔄 Wallpaper chooser script" 2>&1 | tee -a "$LOG"
echo "  - 🚀 Automatic wallpaper initialization" 2>&1 | tee -a "$LOG"
echo "" 2>&1 | tee -a "$LOG"
echo "${NOTE} Usage:" 2>&1 | tee -a "$LOG"
echo "  • Change wallpaper: Super+W" 2>&1 | tee -a "$LOG"
echo "  • Or run: ~/.config/hypr/scripts/wallpaper-chooser.sh" 2>&1 | tee -a "$LOG"
echo "  • Manual wallpaper: swww img /path/to/wallpaper.png" 2>&1 | tee -a "$LOG"
echo "  • Wallpaper location: ~/.config/swww/wallpapers/" 2>&1 | tee -a "$LOG"
echo "" 2>&1 | tee -a "$LOG"

printf "\n%.0s" {1..2}