#!/bin/bash
# 💫 https://github.com/jellydn/Arch-Hyprland 💫 #
# fish shell installation #

fish_pkg=(
  fish
  fisher
  lsd
  fzf
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
LOG="Install-Logs/install-$(date +%d-%H%M%S)_fish.log"

# Installing fish packages
printf "\n%s - Installing ${SKY_BLUE}Fish shell packages${RESET} .... \n" "${NOTE}"
for FISH in "${fish_pkg[@]}"; do
  install_package "$FISH" "$LOG"
done 

# Install Fish shell and configure it
if command -v fish >/dev/null; then
  printf "${NOTE} Configuring ${SKY_BLUE}Fish shell${RESET} ...\n"
  
  # Create fish config directory if it doesn't exist
  mkdir -p "$HOME/.config/fish"
  
  # Check if config.fish exists, create a backup, and copy the new configuration
  if [ -f "$HOME/.config/fish/config.fish" ]; then
      cp -b "$HOME/.config/fish/config.fish" "$HOME/.config/fish/config.fish-backup" || true
  fi
  
  # Copying the preconfigured fish configuration
  cp -r 'assets/fish/config.fish' "$HOME/.config/fish/" || true
  
  # Install Fisher plugin manager and useful plugins
  fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
  
  # Install popular fish plugins
  fish -c "fisher install jethrokuan/z"                    # z - directory jumping
  fish -c "fisher install PatrickF1/fzf.fish"            # fzf integration
  fish -c "fisher install franciscolourenco/done"         # desktop notifications
  fish -c "fisher install gazorby/fish-abbreviation-tips" # abbreviation tips
  
  # Check if the current shell is fish
  current_shell=$(basename "$SHELL")
  if [ "$current_shell" != "fish" ]; then
    printf "${NOTE} Changing default shell to ${MAGENTA}fish${RESET}..."
    printf "\n%.0s" {1..2}

    # Loop to ensure the chsh command succeeds
    while ! chsh -s "$(command -v fish)"; do
      echo "${ERROR} Authentication failed. Please enter the correct password." 2>&1 | tee -a "$LOG"
      sleep 1
    done

    printf "${INFO} Shell changed successfully to ${MAGENTA}fish${RESET}" 2>&1 | tee -a "$LOG"
  else
    echo "${NOTE} Your shell is already set to ${MAGENTA}fish${RESET}."
  fi
  
fi

printf "\n%.0s" {1..2}