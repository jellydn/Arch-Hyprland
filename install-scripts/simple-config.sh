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

# Source the backup functions
if ! source "$(dirname "$(readlink -f "$0")")/backup-config.sh"; then
  echo "Failed to source backup-config.sh"
  exit 1
fi

# Set the name of the log file to include the current date and time
LOG="Install-Logs/install-$(date +%d-%H%M%S)_simple-config.log"

printf "\n%s - Installing ${SKY_BLUE}Simple Tiling Hyprland Configuration${RESET} .... \n" "${NOTE}"

# Create necessary directories  
echo "Creating configuration directories..." 2>&1 | tee -a "$LOG"
mkdir -p "$HOME/.config/hypr/scripts"
mkdir -p "$HOME/.config/waybar"
mkdir -p "$HOME/.config/rofi"
mkdir -p "$HOME/.config/wlogout"
mkdir -p "$HOME/.config/swww"
mkdir -p "$HOME/.config/foot"

# Copy simple configuration files
if [ -d "assets/simple-hyprland" ]; then
  echo "${INFO} Installing Simple KooL Hyprland configuration with complete desktop environment..." 2>&1 | tee -a "$LOG"
  
  # Create backup using the reusable backup function
  create_config_backup "simple-config"
  
  # Copy main Hyprland config (KooL-optimized for performance)
  cp "assets/simple-hyprland/hyprland-kool-optimized.conf" "$HOME/.config/hypr/hyprland.conf"
  
  # Copy Waybar config and styles (KooL-optimized)
  echo "${INFO} Installing KooL-inspired Waybar configuration..." 2>&1 | tee -a "$LOG"
  cp "assets/simple-hyprland/waybar/config-kool.jsonc" "$HOME/.config/waybar/config.jsonc"
  cp "assets/simple-hyprland/waybar/style-kool.css" "$HOME/.config/waybar/style.css"
  
  # Copy Rofi configuration and theme (KooL-optimized)
  echo "${INFO} Installing KooL-style Rofi configuration..." 2>&1 | tee -a "$LOG"
  
  cp "assets/simple-hyprland/rofi/config-kool.rasi" "$HOME/.config/rofi/config.rasi"
  cp "assets/simple-hyprland/rofi/kool-style.rasi" "$HOME/.config/rofi/"
  cp "assets/simple-hyprland/rofi/fonts.rasi" "$HOME/.config/rofi/"
  cp "assets/simple-hyprland/rofi/simple-kool.rasi" "$HOME/.config/rofi/"
  
  # Copy Wlogout configuration and theme
  echo "${INFO} Installing Wlogout configuration..." 2>&1 | tee -a "$LOG"
  cp "assets/simple-hyprland/wlogout/layout" "$HOME/.config/wlogout/"
  cp "assets/simple-hyprland/wlogout/style.css" "$HOME/.config/wlogout/"
  
  # Copy Foot terminal configuration
  echo "${INFO} Installing Foot terminal configuration..." 2>&1 | tee -a "$LOG"
  cp "assets/simple-hyprland/foot.ini" "$HOME/.config/foot/"
  
  # Copy VM auto-scaling script and configuration
  echo "${INFO} Installing VM auto-scaling features..." 2>&1 | tee -a "$LOG"
  cp "assets/simple-hyprland/scripts/vm-scale.sh" "$HOME/.config/hypr/scripts/"
  chmod +x "$HOME/.config/hypr/scripts/vm-scale.sh"
  cp "assets/simple-hyprland/vm-monitor.conf" "$HOME/.config/hypr/"
  
  # Copy which-key helper script (KooL-optimized)
  echo "${INFO} Installing KooL-style Which-Key helper..." 2>&1 | tee -a "$LOG"
  cp "assets/simple-hyprland/scripts/hyprland-which-key-kool.sh" "$HOME/.config/hypr/scripts/hyprland-which-key.sh"
  chmod +x "$HOME/.config/hypr/scripts/hyprland-which-key.sh"
  
  # Copy terminal chooser script
  echo "${INFO} Installing Terminal chooser..." 2>&1 | tee -a "$LOG"
  cp "assets/simple-hyprland/scripts/terminal-chooser.sh" "$HOME/.config/hypr/scripts/"
  chmod +x "$HOME/.config/hypr/scripts/terminal-chooser.sh"
  
  # Copy workspace name script
  echo "${INFO} Installing Workspace navigation..." 2>&1 | tee -a "$LOG"
  cp "assets/simple-hyprland/scripts/workspace-name.sh" "$HOME/.config/hypr/scripts/"
  chmod +x "$HOME/.config/hypr/scripts/workspace-name.sh"
  
  # Copy bash configuration
  echo "${INFO} Installing Bash configuration..." 2>&1 | tee -a "$LOG"
  if [ ! -f "$HOME/.bashrc.backup" ]; then
    cp "$HOME/.bashrc" "$HOME/.bashrc.backup" 2>/dev/null || true
  fi
  cat "assets/simple-hyprland/bashrc" >> "$HOME/.bashrc" 2>/dev/null || cp "assets/simple-hyprland/bashrc" "$HOME/.bashrc"
  
  # Setup wallpaper system using dedicated installer
  if [ -f "install-scripts/wallpaper.sh" ]; then
    echo "${INFO} Installing wallpaper system..." 2>&1 | tee -a "$LOG"
    ./install-scripts/wallpaper.sh 2>&1 | tee -a "$LOG"
  else
    echo "${ERROR} Wallpaper installer script not found!" 2>&1 | tee -a "$LOG"
  fi
  
  echo "${OK} KooL-Optimized Hyprland Desktop Environment installed successfully!" 2>&1 | tee -a "$LOG"
  echo "${INFO} Complete desktop environment features:" 2>&1 | tee -a "$LOG"
  echo "  - 🎯 Waybar status bar with enhanced date/time, network details, volume control" 2>&1 | tee -a "$LOG"
  echo "  - 🚀 Rofi application launcher with search and file browsing" 2>&1 | tee -a "$LOG"
  echo "  - 🚪 Wlogout power menu with lock, logout, shutdown, reboot, suspend" 2>&1 | tee -a "$LOG"
  echo "  - 󰌌 Which-Key helper for easy keybinding discovery (Super + /)" 2>&1 | tee -a "$LOG"
  echo "  - 🔧 VM auto-scaling (detects VMware, VirtualBox, UTM, Parallels)" 2>&1 | tee -a "$LOG"
  echo "  - ⚡ KooL's advanced tiling with performance optimization" 2>&1 | tee -a "$LOG"
  echo "  - 🎨 KooL styling with Catppuccin Mocha colors (static, no wallust)" 2>&1 | tee -a "$LOG"
  echo "  - 🖼️ Default wallpaper collection with easy wallpaper chooser" 2>&1 | tee -a "$LOG"
  echo "  - 🦶 Foot terminal with VM-optimized configuration" 2>&1 | tee -a "$LOG"
  echo "  - 🚫 NO ANIMATIONS - Maximum VM performance" 2>&1 | tee -a "$LOG"
  echo "  - ⚡ Minimal blur and effects for optimal VM experience" 2>&1 | tee -a "$LOG"
  echo "" 2>&1 | tee -a "$LOG"
  echo "${NOTE} Essential key bindings:" 2>&1 | tee -a "$LOG"
  echo "  Super+Return       : Open terminal (current)" 2>&1 | tee -a "$LOG"
  echo "  Super+Shift+Return : Choose terminal (foot/kitty/alacritty/etc)" 2>&1 | tee -a "$LOG"
  echo "  Super+B       : Open browser (firefox)" 2>&1 | tee -a "$LOG"
  echo "  Super+D       : Application launcher (rofi)" 2>&1 | tee -a "$LOG"
  echo "  Super+R       : Run command (rofi)" 2>&1 | tee -a "$LOG"
  echo "  Super+Q       : Close window" 2>&1 | tee -a "$LOG"
  echo "  Super+V       : Toggle floating/tiled" 2>&1 | tee -a "$LOG"
  echo "  Super+F       : Fullscreen" 2>&1 | tee -a "$LOG"
  echo "  Super+1-9     : Switch workspaces" 2>&1 | tee -a "$LOG"
  echo "  Super+Shift+R : Reload configuration" 2>&1 | tee -a "$LOG"
  echo "  Super+W       : Change wallpaper (wallpaper chooser)" 2>&1 | tee -a "$LOG"
  echo "  Super+/       : Show keybinding help (Which-Key)" 2>&1 | tee -a "$LOG"
  echo "" 2>&1 | tee -a "$LOG"
  echo "${NOTE} Desktop interactions:" 2>&1 | tee -a "$LOG"
  echo "  • Click Waybar OS logo → Launch rofi" 2>&1 | tee -a "$LOG"
  echo "  • Click Waybar which-key button (󰌌) → Show keybinding help" 2>&1 | tee -a "$LOG"
  echo "  • Click Waybar volume → Open pavucontrol" 2>&1 | tee -a "$LOG"
  echo "  • Click Waybar power → Open logout menu" 2>&1 | tee -a "$LOG"
  echo "  • VM auto-scaling detects and optimizes display automatically" 2>&1 | tee -a "$LOG"
  echo "" 2>&1 | tee -a "$LOG"
  echo "${NOTE} Wallpaper Management:" 2>&1 | tee -a "$LOG"
  echo "  • Default wallpapers: ~/.config/swww/wallpapers/" 2>&1 | tee -a "$LOG"
  echo "  • Change wallpaper: ~/.config/hypr/scripts/wallpaper-chooser.sh" 2>&1 | tee -a "$LOG"
  echo "  • Set wallpaper manually: swww img /path/to/wallpaper.png" 2>&1 | tee -a "$LOG"
  echo "  • Add custom wallpapers: copy to ~/.config/swww/wallpapers/" 2>&1 | tee -a "$LOG"
  echo "" 2>&1 | tee -a "$LOG"
  echo "${NOTE} Shell Configuration:" 2>&1 | tee -a "$LOG"
  echo "  • Default shell: bash (configured with useful aliases)" 2>&1 | tee -a "$LOG"
  echo "  • To change shell: ./install-scripts/shell-chooser.sh" 2>&1 | tee -a "$LOG"
  echo "  • Or manually: chsh -s /bin/zsh (then logout/login)" 2>&1 | tee -a "$LOG"
  echo "" 2>&1 | tee -a "$LOG"
  echo "${NOTE} 📝 CUSTOMIZATION GUIDE:" 2>&1 | tee -a "$LOG"
  echo "  Configuration file: ~/.config/hyprland/hyprland.conf" 2>&1 | tee -a "$LOG"
  echo "  Based on: KooL's dotfiles structure (github.com/JaKooLit/Hyprland-Dots)" 2>&1 | tee -a "$LOG"
  echo "" 2>&1 | tee -a "$LOG"
  echo "  🔧 To customize after installation:" 2>&1 | tee -a "$LOG"
  echo "  1. Edit config: nano ~/.config/hyprland/hyprland.conf" 2>&1 | tee -a "$LOG"
  echo "  2. Reload config: Super+Shift+R (or restart Hyprland)" 2>&1 | tee -a "$LOG"
  echo "" 2>&1 | tee -a "$LOG"
  echo "  ⚡ Quick customizations:" 2>&1 | tee -a "$LOG"
  echo "  • Change terminal: Edit '\$term = foot' to '\$term = kitty'" 2>&1 | tee -a "$LOG"
  echo "  • Change browser: Edit '\$browser = firefox' to '\$browser = brave'" 2>&1 | tee -a "$LOG"
  echo "  • Adjust gaps: Edit 'gaps_in = 3' and 'gaps_out = 8'" 2>&1 | tee -a "$LOG"
  echo "  • Change colors: Edit 'col.active_border' and 'col.inactive_border'" 2>&1 | tee -a "$LOG"
  echo "  • Change wallpaper: Run ~/.config/hypr/scripts/wallpaper-chooser.sh" 2>&1 | tee -a "$LOG"
  echo "  • Add keybinds: Add 'bind = \$mainMod, KEY, exec, COMMAND'" 2>&1 | tee -a "$LOG"
  echo "" 2>&1 | tee -a "$LOG"
  echo "  🌐 Resources:" 2>&1 | tee -a "$LOG"
  echo "  • Hyprland Wiki: https://wiki.hyprland.org/" 2>&1 | tee -a "$LOG"
  echo "  • KooL Dotfiles: https://github.com/JaKooLit/Hyprland-Dots" 2>&1 | tee -a "$LOG"
  echo "  • Re-run simple config: ./install-scripts/simple-config.sh" 2>&1 | tee -a "$LOG"
  echo "  • Or from main dir: ./install.sh --simple-config" 2>&1 | tee -a "$LOG"
  echo "" 2>&1 | tee -a "$LOG"
  
  # Display backup information and rollback instructions
  show_rollback_instructions
  cleanup_old_backups
  create_user_backup_script
  
  echo "${OK} Happy customizing! 🎨" 2>&1 | tee -a "$LOG"
  
else
  echo "${ERROR} Simple configuration file not found!" 2>&1 | tee -a "$LOG"
  exit 1
fi

printf "\n%.0s" {1..2}