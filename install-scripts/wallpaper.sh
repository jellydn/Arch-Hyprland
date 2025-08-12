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

# Create necessary directories
echo "${INFO} Setting up simple wallpaper system..." 2>&1 | tee -a "$LOG"
mkdir -p "$HOME/.config/swww/wallpapers"
mkdir -p "$HOME/.config/hypr/scripts"

# Copy wallpaper scripts
if [ -f "assets/simple-hyprland/scripts/wallpaper-chooser.sh" ]; then
    echo "${INFO} Installing wallpaper chooser script..." 2>&1 | tee -a "$LOG"
    cp "assets/simple-hyprland/scripts/wallpaper-chooser.sh" "$HOME/.config/hypr/scripts/"
    chmod +x "$HOME/.config/hypr/scripts/wallpaper-chooser.sh"
fi

if [ -f "assets/simple-hyprland/scripts/wallpaper-init.sh" ]; then
    echo "${INFO} Installing wallpaper initialization script..." 2>&1 | tee -a "$LOG"
    cp "assets/simple-hyprland/scripts/wallpaper-init.sh" "$HOME/.config/hypr/scripts/"
    chmod +x "$HOME/.config/hypr/scripts/wallpaper-init.sh"
fi

# Run simple setup
if [ -f "assets/simple-hyprland/wallpapers/simple-setup.sh" ]; then
    echo "${INFO} Running simple wallpaper setup..." 2>&1 | tee -a "$LOG"
    ./assets/simple-hyprland/wallpapers/simple-setup.sh 2>&1 | tee -a "$LOG"
else
    # Direct fallback
    echo "${INFO} Creating basic wallpaper setup..." 2>&1 | tee -a "$LOG"
    mkdir -p "$HOME/.config/swww/wallpapers"
    touch "$HOME/.config/swww/wall.png.missing" # Marker for init script
fi

# Create default wallpapers if script exists
if [ -f "assets/simple-hyprland/wallpapers/create-defaults.sh" ]; then
    echo "${INFO} Creating default wallpapers..." 2>&1 | tee -a "$LOG"
    chmod +x "assets/simple-hyprland/wallpapers/create-defaults.sh"
    ./assets/simple-hyprland/wallpapers/create-defaults.sh 2>&1 | tee -a "$LOG"
fi

echo "${OK} Simple wallpaper system installed!" 2>&1 | tee -a "$LOG"
echo "${INFO} Features:" 2>&1 | tee -a "$LOG"
echo "  - 🎨 Automatic wallpaper initialization on startup" 2>&1 | tee -a "$LOG"
echo "  - 🖼️  Default color wallpapers included" 2>&1 | tee -a "$LOG"
echo "  - 🔄 Interactive wallpaper chooser (Super+W)" 2>&1 | tee -a "$LOG"
echo "  - 🚀 Reliable fallback to solid colors" 2>&1 | tee -a "$LOG"
echo "" 2>&1 | tee -a "$LOG"
echo "${NOTE} Usage:" 2>&1 | tee -a "$LOG"
echo "  • Choose wallpaper: Super+W" 2>&1 | tee -a "$LOG"
echo "  • Set custom wallpaper: swww img /path/to/wallpaper.png" 2>&1 | tee -a "$LOG"
echo "  • Add wallpapers to: ~/.config/swww/wallpapers/" 2>&1 | tee -a "$LOG"
echo "  • System will auto-restore wallpaper on login" 2>&1 | tee -a "$LOG"
echo "" 2>&1 | tee -a "$LOG"

printf "\n%.0s" {1..2}