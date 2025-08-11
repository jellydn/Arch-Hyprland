#!/bin/bash
# 💫 https://github.com/jellydn/Arch-Hyprland 💫 #
# Ghostty terminal emulator installation #

ghostty_pkg=(
  ghostty
)

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
LOG="Install-Logs/install-$(date +%d-%H%M%S)_ghostty.log"

# Installing ghostty packages
printf "\n%s - Installing ${SKY_BLUE}Ghostty terminal emulator${RESET} .... \n" "${NOTE}"
for GHOSTTY in "${ghostty_pkg[@]}"; do
  install_package "$GHOSTTY" "$LOG"
done 

# Configure ghostty if installed successfully
if command -v ghostty >/dev/null; then
  printf "${NOTE} Configuring ${SKY_BLUE}Ghostty terminal${RESET} ...\n"
  
  # Create ghostty config directory if it doesn't exist
  mkdir -p "$HOME/.config/ghostty"
  
  # Check if config exists, create a backup
  if [ -f "$HOME/.config/ghostty/config" ]; then
      cp -b "$HOME/.config/ghostty/config" "$HOME/.config/ghostty/config-backup" || true
  fi
  
  # Copy ghostty configuration if it exists in assets
  if [ -f "assets/ghostty/config" ]; then
    cp 'assets/ghostty/config' "$HOME/.config/ghostty/" || true
    echo "${INFO} Ghostty configuration applied successfully." 2>&1 | tee -a "$LOG"
  else
    echo "${NOTE} No ghostty configuration found in assets. Using default configuration." 2>&1 | tee -a "$LOG"
  fi
  
fi

printf "\n%.0s" {1..2}