#!/bin/bash
# 💫 https://github.com/jellydn/Arch-Hyprland 💫 #
# Open VMware Tools installer for enhanced VM integration #

# Packages needed for VMware Tools
vmware_base_packages=(
  base-devel
  autoconf
  automake
  libtool
  xorg-server-devel
  glib2-devel
  pkg-config
  xmlsec
)

############## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##############
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change the working directory to the parent directory of the script
PARENT_DIR="$SCRIPT_DIR/.."
cd "$PARENT_DIR" || { echo "${ERROR} Failed to change directory to $PARENT_DIR"; exit 1; }

# Source the global functions script
if ! source "$PARENT_DIR/install-scripts/Global_functions.sh"; then
  echo "Failed to source Global_functions.sh"
  exit 1
fi

# Set the name of the log file to include the current date and time
LOG="Install-Logs/install-$(date +%d-%H%M%S)_openvm-tools.log"

printf "\n%s - Installing ${SKY_BLUE}Open VMware Tools${RESET} for enhanced VM integration...\n" "${NOTE}"

# Install base development packages
printf "\n%s - Installing ${YELLOW}base development packages${RESET}...\n" "${NOTE}"
for PKG in "${vmware_base_packages[@]}"; do
  install_package_pacman "$PKG" "$LOG"
done

# Clone VMware Tools repository
printf "\n%s - Cloning ${YELLOW}VMware Tools repository${RESET}...\n" "${NOTE}"
if [ -d "vmware-tools" ]; then
  echo -e "${INFO} Removing existing vmware-tools directory..."
  rm -rf vmware-tools
fi

if git clone https://github.com/daimaou92/install-arch-vmwarefusion-techpreview.git vmware-tools 2>&1 | tee -a "$LOG"; then
  echo -e "${OK} VMware Tools repository cloned successfully!"
else
  echo -e "${ERROR} Failed to clone VMware Tools repository. Check your internet connection."
  exit 1
fi

# Build and install Open VMware Tools
printf "\n%s - Building and installing ${YELLOW}Open VMware Tools${RESET}...\n" "${NOTE}"
if [ -d "~/open-vm-tools" ]; then
  echo -e "${INFO} Removing existing open-vm-tools directory..."
  rm -rf ~/open-vm-tools
fi

if [ -d "vmware-tools/after/openvmtools" ]; then
  cd vmware-tools/after/openvmtools || { echo -e "${ERROR} Failed to change directory to vmware-tools/after/openvmtools"; exit 1; }
  
  if bash build.sh 2>&1 | tee -a "$PARENT_DIR/$LOG"; then
    echo -e "${OK} Open VMware Tools built and installed successfully!"
  else
    echo -e "${ERROR} Failed to build Open VMware Tools. Check the log for details."
    exit 1
  fi
  
  cd "$PARENT_DIR" || exit 1
else
  echo -e "${ERROR} VMware Tools build directory not found!"
  exit 1
fi

# Ask user about reboot
printf "\n%s - Open VMware Tools installation completed!\n" "${OK}"
printf "%s - A system reboot is ${YELLOW}highly recommended${RESET} to apply all changes.\n" "${NOTE}"
printf "%s - Would you like to reboot now? (y/N): " "${CAT}"
read -r reboot_choice

case "$reboot_choice" in
  [Yy]* )
    echo -e "${NOTE} Rebooting system..."
    sudo reboot
    ;;
  * )
    echo -e "${INFO} Reboot skipped. Please reboot manually when convenient."
    echo -e "${NOTE} Run 'sudo reboot' when ready to complete the installation."
    ;;
esac

printf "\n%.0s" {1..2}
