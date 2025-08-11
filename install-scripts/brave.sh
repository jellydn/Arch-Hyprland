#!/bin/bash
# 💫 https://github.com/jellydn/Arch-Hyprland 💫 #
# Brave browser installation #

brave_pkg=(
  brave-bin
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
LOG="Install-Logs/install-$(date +%d-%H%M%S)_brave.log"

# Installing brave packages
printf "\n%s - Installing ${SKY_BLUE}Brave browser${RESET} .... \n" "${NOTE}"
for BRAVE in "${brave_pkg[@]}"; do
  install_package "$BRAVE" "$LOG"
done 

# Configure brave if installed successfully
if command -v brave >/dev/null; then
  printf "${NOTE} ${SKY_BLUE}Brave${RESET} installed successfully.\n"
  
  # Create brave configuration directory if needed
  if [ -d "assets/brave" ]; then
    echo "${INFO} Brave configuration files found in assets. You can customize them manually." 2>&1 | tee -a "$LOG"
  else
    echo "${NOTE} No Brave configuration found in assets. Using default configuration." 2>&1 | tee -a "$LOG"
  fi
  
fi

printf "\n%.0s" {1..2}