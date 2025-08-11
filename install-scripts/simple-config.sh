#!/bin/bash
# 💫 https://github.com/jellydn/Arch-Hyprland 💫 #
# Simple Hyprland Configuration (Non-tiled, VM-optimized) #

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
LOG="Install-Logs/install-$(date +%d-%H%M%S)_simple-config.log"

printf "\n%s - Installing ${SKY_BLUE}Simple Tiling Hyprland Configuration${RESET} .... \n" "${NOTE}"

# Create necessary directories
echo "Creating Hyprland configuration directories..." 2>&1 | tee -a "$LOG"
mkdir -p "$HOME/.config/hypr"
mkdir -p "$HOME/.config/swww"

# Copy simple configuration
if [ -f "assets/simple-hyprland/hyprland.conf" ]; then
  echo "${INFO} Installing simple non-tiled Hyprland configuration..." 2>&1 | tee -a "$LOG"
  cp "assets/simple-hyprland/hyprland.conf" "$HOME/.config/hypr/"
  
  # Create a simple wallpaper directory and default wallpaper
  if [ ! -f "$HOME/.config/swww/wall.png" ]; then
    echo "${INFO} Creating default wallpaper..." 2>&1 | tee -a "$LOG"
    # Create a simple solid color wallpaper if no wallpaper exists
    if command -v convert >/dev/null; then
      convert -size 1920x1080 xc:"#1e1e2e" "$HOME/.config/swww/wall.png" 2>/dev/null || {
        echo "${NOTE} ImageMagick not available, will use system default wallpaper" 2>&1 | tee -a "$LOG"
        touch "$HOME/.config/swww/wall.png"
      }
    else
      echo "${NOTE} No wallpaper tool available, will use system default" 2>&1 | tee -a "$LOG"
      touch "$HOME/.config/swww/wall.png"
    fi
  fi
  
  echo "${OK} Simple Hyprland configuration installed successfully!" 2>&1 | tee -a "$LOG"
  echo "${INFO} Configuration features:" 2>&1 | tee -a "$LOG"
  echo "  - ⚡ Embraces Hyprland's tiling power!" 2>&1 | tee -a "$LOG"
  echo "  - 🎨 KooL styling with catppuccin colors" 2>&1 | tee -a "$LOG"
  echo "  - Uses Foot terminal and Firefox browser" 2>&1 | tee -a "$LOG"
  echo "  - Simple keybindings (Super+Return=terminal, Super+B=browser)" 2>&1 | tee -a "$LOG"
  echo "  - Minimal animations for better performance" 2>&1 | tee -a "$LOG"
  echo "" 2>&1 | tee -a "$LOG"
  echo "${NOTE} Key bindings:" 2>&1 | tee -a "$LOG"
  echo "  Super+Return  : Open terminal (foot)" 2>&1 | tee -a "$LOG"
  echo "  Super+B       : Open browser (firefox)" 2>&1 | tee -a "$LOG"
  echo "  Super+D       : Application launcher" 2>&1 | tee -a "$LOG"
  echo "  Super+Q       : Close window" 2>&1 | tee -a "$LOG"
  echo "  Super+V       : Toggle floating/tiled" 2>&1 | tee -a "$LOG"
  echo "  Super+F       : Toggle fullscreen" 2>&1 | tee -a "$LOG"
  echo "  Super+1-9     : Switch workspaces" 2>&1 | tee -a "$LOG"
  echo "" 2>&1 | tee -a "$LOG"
  echo "${NOTE} 📝 CUSTOMIZATION GUIDE:" 2>&1 | tee -a "$LOG"
  echo "  Configuration file: ~/.config/hypr/hyprland.conf" 2>&1 | tee -a "$LOG"
  echo "" 2>&1 | tee -a "$LOG"
  echo "  🔧 To customize after installation:" 2>&1 | tee -a "$LOG"
  echo "  1. Edit config: nano ~/.config/hypr/hyprland.conf" 2>&1 | tee -a "$LOG"
  echo "  2. Reload config: Super+Shift+R (or restart Hyprland)" 2>&1 | tee -a "$LOG"
  echo "" 2>&1 | tee -a "$LOG"
  echo "  ⚡ Quick customizations:" 2>&1 | tee -a "$LOG"
  echo "  • Change terminal: Edit '\$term = foot' to '\$term = kitty'" 2>&1 | tee -a "$LOG"
  echo "  • Change browser: Edit '\$browser = firefox' to '\$browser = brave'" 2>&1 | tee -a "$LOG"
  echo "  • Adjust gaps: Edit 'gaps_in = 3' and 'gaps_out = 8'" 2>&1 | tee -a "$LOG"
  echo "  • Change colors: Edit 'col.active_border' and 'col.inactive_border'" 2>&1 | tee -a "$LOG"
  echo "  • Add keybinds: Add 'bind = \$mainMod, KEY, exec, COMMAND'" 2>&1 | tee -a "$LOG"
  echo "" 2>&1 | tee -a "$LOG"
  echo "  🌐 Resources:" 2>&1 | tee -a "$LOG"
  echo "  • Hyprland Wiki: https://wiki.hyprland.org/" 2>&1 | tee -a "$LOG"
  echo "  • KooL Dotfiles: https://github.com/JaKooLit/Hyprland-Dots" 2>&1 | tee -a "$LOG"
  echo "  • Re-run simple config: ./install-scripts/simple-config.sh" 2>&1 | tee -a "$LOG"
  echo "  • Or from main dir: ./install.sh --simple-config" 2>&1 | tee -a "$LOG"
  echo "" 2>&1 | tee -a "$LOG"
  echo "${OK} Happy customizing! 🎨" 2>&1 | tee -a "$LOG"
  
else
  echo "${ERROR} Simple configuration file not found!" 2>&1 | tee -a "$LOG"
  exit 1
fi

printf "\n%.0s" {1..2}