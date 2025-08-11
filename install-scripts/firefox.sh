#!/bin/bash
# 💫 https://github.com/jellydn/Arch-Hyprland 💫 #
# Firefox browser installation #

firefox_pkg=(
  firefox
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
LOG="Install-Logs/install-$(date +%d-%H%M%S)_firefox.log"

# Installing firefox packages
printf "\n%s - Installing ${SKY_BLUE}Firefox browser${RESET} .... \n" "${NOTE}"
for FIREFOX in "${firefox_pkg[@]}"; do
  install_package "$FIREFOX" "$LOG"
done 

# Configure firefox if installed successfully
if command -v firefox >/dev/null; then
  printf "${NOTE} ${SKY_BLUE}Firefox${RESET} installed successfully.\n"
  
  # Create firefox profile directory if it doesn't exist and copy configurations
  if [ -d "assets/firefox" ]; then
    echo "${INFO} Firefox configuration files found in assets. You can customize them manually." 2>&1 | tee -a "$LOG"
  else
    echo "${NOTE} No Firefox configuration found in assets. Using default configuration." 2>&1 | tee -a "$LOG"
  fi
  
fi

printf "\n%.0s" {1..2}