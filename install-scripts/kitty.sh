#!/bin/bash
# 💫 https://github.com/jellydn/Arch-Hyprland 💫 #
# Kitty terminal emulator installation #

kitty_pkg=(
  kitty
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
LOG="Install-Logs/install-$(date +%d-%H%M%S)_kitty.log"

# Installing kitty packages
printf "\n%s - Installing ${SKY_BLUE}Kitty terminal emulator${RESET} .... \n" "${NOTE}"
for KITTY in "${kitty_pkg[@]}"; do
  install_package "$KITTY" "$LOG"
done 

# Configure kitty if installed successfully
if command -v kitty >/dev/null; then
  printf "${NOTE} Configuring ${SKY_BLUE}Kitty terminal${RESET} ...\n"
  
  # Create kitty config directory if it doesn't exist
  mkdir -p "$HOME/.config/kitty"
  
  # Check if kitty.conf exists, create a backup
  if [ -f "$HOME/.config/kitty/kitty.conf" ]; then
      cp -b "$HOME/.config/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf-backup" || true
  fi
  
  # Copy kitty configuration if it exists in assets
  if [ -f "assets/kitty/kitty.conf" ]; then
    cp 'assets/kitty/kitty.conf' "$HOME/.config/kitty/" || true
    echo "${INFO} Kitty configuration applied successfully." 2>&1 | tee -a "$LOG"
  else
    echo "${NOTE} No kitty configuration found in assets. Using default configuration." 2>&1 | tee -a "$LOG"
  fi
  
fi

printf "\n%.0s" {1..2}