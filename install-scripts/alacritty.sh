#!/bin/bash
# 💫 https://github.com/jellydn/Arch-Hyprland 💫 #
# Alacritty terminal installation #

alacritty_pkg=(
  alacritty
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
LOG="Install-Logs/install-$(date +%d-%H%M%S)_alacritty.log"

# Installing alacritty packages
printf "\n%s - Installing ${SKY_BLUE}Alacritty terminal${RESET} .... \n" "${NOTE}"
for ALACRITTY in "${alacritty_pkg[@]}"; do
  install_package "$ALACRITTY" "$LOG"
done 

# Configure alacritty if installed successfully
if command -v alacritty >/dev/null; then
  printf "${NOTE} ${SKY_BLUE}Alacritty${RESET} installed successfully.\n"
  
  # Create alacritty configuration directory if it doesn't exist
  mkdir -p "$HOME/.config/alacritty"
  
  # Copy configuration if available in assets
  if [ -f "assets/alacritty/alacritty.toml" ]; then
    echo "${INFO} Copying Alacritty configuration from assets..." 2>&1 | tee -a "$LOG"
    cp -r assets/alacritty/* "$HOME/.config/alacritty/"
  elif [ -d "assets/alacritty" ]; then
    echo "${INFO} Alacritty configuration files found in assets. You can customize them manually." 2>&1 | tee -a "$LOG"
  else
    echo "${NOTE} No Alacritty configuration found in assets. Using default configuration." 2>&1 | tee -a "$LOG"
    echo "${INFO} You can create ~/.config/alacritty/alacritty.toml to customize Alacritty." 2>&1 | tee -a "$LOG"
  fi
  
fi

printf "\n%.0s" {1..2}