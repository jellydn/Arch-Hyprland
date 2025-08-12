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

# Copy wallpaper chooser script (optional)
if [ -f "assets/simple-hyprland/scripts/wallpaper-chooser.sh" ]; then
    echo "${INFO} Installing wallpaper chooser script..." 2>&1 | tee -a "$LOG"
    cp "assets/simple-hyprland/scripts/wallpaper-chooser.sh" "$HOME/.config/hypr/scripts/"
    chmod +x "$HOME/.config/hypr/scripts/wallpaper-chooser.sh"
fi

# Run simple setup
if [ -f "assets/simple-hyprland/wallpapers/simple-setup.sh" ]; then
    echo "${INFO} Running simple wallpaper setup..." 2>&1 | tee -a "$LOG"
    ./assets/simple-hyprland/wallpapers/simple-setup.sh 2>&1 | tee -a "$LOG"
else
    # Direct fallback
    echo "${INFO} Creating basic wallpaper setup..." 2>&1 | tee -a "$LOG"
    mkdir -p "$HOME/.config/swww/wallpapers"
    ln -sf /dev/null "$HOME/.config/swww/wall.png" 2>/dev/null || true
fi

echo "${OK} Simple wallpaper system installed!" 2>&1 | tee -a "$LOG"
echo "${INFO} Features:" 2>&1 | tee -a "$LOG"
echo "  - 🎨 Solid color background (fallback)" 2>&1 | tee -a "$LOG"
echo "  - 🔄 Wallpaper chooser script (if available)" 2>&1 | tee -a "$LOG"
echo "  - 🚀 Simple swww setup" 2>&1 | tee -a "$LOG"
echo "" 2>&1 | tee -a "$LOG"
echo "${NOTE} Usage:" 2>&1 | tee -a "$LOG"
echo "  • Set wallpaper: swww img /path/to/wallpaper.png" 2>&1 | tee -a "$LOG"
echo "  • Change wallpaper: Super+W (if available)" 2>&1 | tee -a "$LOG"
echo "  • Add wallpapers to: ~/.config/swww/wallpapers/" 2>&1 | tee -a "$LOG"
echo "  • Current: Solid color background (#1e1e2e)" 2>&1 | tee -a "$LOG"
echo "" 2>&1 | tee -a "$LOG"

printf "\n%.0s" {1..2}