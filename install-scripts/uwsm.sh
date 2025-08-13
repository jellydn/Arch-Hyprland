#!/bin/bash
# 💫 https://github.com/JaKooLit 💫 #
# Universal Wayland Session Manager Installation #

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
LOG="Install-Logs/install-$(date +%d-%H%M%S)_uwsm.log"

# Installation of UWSM
printf "\n%s - Installing ${SKY_BLUE}Universal Wayland Session Manager (UWSM)${RESET} .... \n" "${NOTE}"
printf "\n%s - This enables proper session management for Hyprland with XDG autostart support\n" "${INFO}"

uwsm_package=(
  uwsm
)

for PKG in "${uwsm_package[@]}"; do
  install_package "$PKG" "$LOG"
done

# Configure UWSM for Hyprland
printf "\n%s - Configuring ${SKY_BLUE}UWSM for Hyprland${RESET} .... \n" "${NOTE}"

# Create UWSM user config directory
if [ ! -d "$HOME/.config/uwsm" ]; then
  mkdir -p "$HOME/.config/uwsm" 2>&1 | tee -a "$LOG"
  printf "%s - Created UWSM config directory\n" "${OK}"
fi

# Create Hyprland desktop entry for UWSM
cat > "$HOME/.config/uwsm/hyprland.desktop" <<EOF
[Desktop Entry]
Name=Hyprland
Comment=An intelligent dynamic tiling Wayland compositor
Exec=Hyprland
Type=Application
DesktopNames=Hyprland
Keywords=tiling;wayland;compositor;
EOF

if [ $? -eq 0 ]; then
  printf "%s - Created UWSM Hyprland configuration\n" "${OK}"
else
  printf "%s - Failed to create UWSM Hyprland configuration\n" "${ERROR}"
fi

# Set Hyprland as default compositor for UWSM
echo "hyprland.desktop" > "$HOME/.config/uwsm/default-id"

if [ $? -eq 0 ]; then
  printf "%s - Set Hyprland as default UWSM compositor\n" "${OK}"
else
  printf "%s - Failed to set default UWSM compositor\n" "${ERROR}"
fi

printf "\n%s - UWSM installation and configuration completed!\n" "${OK}"
printf "%s - You can now use 'Hyprland (uwsm-managed)' session from login screen\n" "${INFO}"
printf "%s - This provides proper session management with XDG autostart support\n" "${INFO}"
printf "\n%.0s" {1..2}