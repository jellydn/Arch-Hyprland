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
mkdir -p "$HOME/.config/hypr/waybar"
mkdir -p "$HOME/.config/hypr/rofi"
mkdir -p "$HOME/.config/hypr/scripts"
mkdir -p "$HOME/.config/wlogout"
mkdir -p "$HOME/.config/swww"

# Copy simple configuration files
if [ -d "assets/simple-hyprland" ]; then
  echo "${INFO} Installing Simple KooL Hyprland configuration with complete desktop environment..." 2>&1 | tee -a "$LOG"
  
  # Copy main Hyprland config
  cp "assets/simple-hyprland/hyprland.conf" "$HOME/.config/hypr/"
  
  # Copy Waybar config and styles
  echo "${INFO} Installing Waybar configuration..." 2>&1 | tee -a "$LOG"
  cp "assets/simple-hyprland/waybar/config.jsonc" "$HOME/.config/hypr/waybar/"
  cp "assets/simple-hyprland/waybar/style.css" "$HOME/.config/hypr/waybar/"
  
  # Copy Rofi configuration and theme
  echo "${INFO} Installing Rofi configuration..." 2>&1 | tee -a "$LOG"
  cp "assets/simple-hyprland/rofi/config.rasi" "$HOME/.config/hypr/rofi/"
  cp "assets/simple-hyprland/rofi/fonts.rasi" "$HOME/.config/hypr/rofi/"
  cp "assets/simple-hyprland/rofi/simple-kool.rasi" "$HOME/.config/hypr/rofi/"
  
  # Copy Wlogout configuration and theme
  echo "${INFO} Installing Wlogout configuration..." 2>&1 | tee -a "$LOG"
  cp "assets/simple-hyprland/wlogout/layout" "$HOME/.config/wlogout/"
  cp "assets/simple-hyprland/wlogout/style.css" "$HOME/.config/wlogout/"
  
  # Copy VM auto-scaling script
  echo "${INFO} Installing VM auto-scaling features..." 2>&1 | tee -a "$LOG"
  cp "assets/simple-hyprland/scripts/vm-scale.sh" "$HOME/.config/hypr/scripts/"
  chmod +x "$HOME/.config/hypr/scripts/vm-scale.sh"
  cp "assets/simple-hyprland/vm-monitor.conf" "$HOME/.config/hypr/"
  
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
  
  echo "${OK} Simple KooL Hyprland Desktop Environment installed successfully!" 2>&1 | tee -a "$LOG"
  echo "${INFO} Complete desktop environment features:" 2>&1 | tee -a "$LOG"
  echo "  - 🎯 Waybar status bar with enhanced date/time, network details, volume control" 2>&1 | tee -a "$LOG"
  echo "  - 🚀 Rofi application launcher with search and file browsing" 2>&1 | tee -a "$LOG"
  echo "  - 🚪 Wlogout power menu with lock, logout, shutdown, reboot, suspend" 2>&1 | tee -a "$LOG"
  echo "  - 🔧 VM auto-scaling (detects VMware, VirtualBox, UTM, Parallels)" 2>&1 | tee -a "$LOG"
  echo "  - ⚡ Embraces Hyprland's tiling power with smart workspace organization" 2>&1 | tee -a "$LOG"
  echo "  - 🎨 KooL styling with Catppuccin Mocha colors" 2>&1 | tee -a "$LOG"
  echo "  - 🦶 VM-optimized (Foot terminal, optimized animations)" 2>&1 | tee -a "$LOG"
  echo "" 2>&1 | tee -a "$LOG"
  echo "${NOTE} Essential key bindings:" 2>&1 | tee -a "$LOG"
  echo "  Super+Return  : Open terminal (foot)" 2>&1 | tee -a "$LOG"
  echo "  Super+B       : Open browser (firefox)" 2>&1 | tee -a "$LOG"
  echo "  Super+D       : Application launcher (rofi)" 2>&1 | tee -a "$LOG"
  echo "  Super+R       : Run command (rofi)" 2>&1 | tee -a "$LOG"
  echo "  Super+Q       : Close window" 2>&1 | tee -a "$LOG"
  echo "  Super+V       : Toggle floating/tiled" 2>&1 | tee -a "$LOG"
  echo "  Super+F       : Fullscreen" 2>&1 | tee -a "$LOG"
  echo "  Super+1-9     : Switch workspaces" 2>&1 | tee -a "$LOG"
  echo "  Super+Shift+R : Reload configuration" 2>&1 | tee -a "$LOG"
  echo "" 2>&1 | tee -a "$LOG"
  echo "${NOTE} Desktop interactions:" 2>&1 | tee -a "$LOG"
  echo "  • Click Waybar OS logo → Launch rofi" 2>&1 | tee -a "$LOG"
  echo "  • Click Waybar volume → Open pavucontrol" 2>&1 | tee -a "$LOG"
  echo "  • Click Waybar power → Open logout menu" 2>&1 | tee -a "$LOG"
  echo "  • VM auto-scaling detects and optimizes display automatically" 2>&1 | tee -a "$LOG"
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