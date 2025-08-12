#!/bin/bash
# 💫 https://github.com/jellydn/Arch-Hyprland 💫 #
# Open VMware Tools installer for enhanced VM integration #

# VMware Tools build dependencies
vmware_build_deps=(
    base-devel
    autoconf
    automake
    libtool
    xorg-server-devel
    glib2-devel
    pkg-config
    xmlsec
    git
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
LOG="Install-Logs/install-$(date +%d-%H%M%S)_openvm-tools.log"

printf "\n%s - Installing ${SKY_BLUE}Open VMware Tools${RESET} .... \n" "${NOTE}"

# Check if running in a VMware environment
if ! systemd-detect-virt | grep -q "vmware"; then
    echo "${WARNING} This script is designed for VMware virtual machines." 2>&1 | tee -a "$LOG"
    echo "${NOTE} Current virtualization: $(systemd-detect-virt 2>/dev/null || echo 'Unknown')" 2>&1 | tee -a "$LOG"
    echo "${NOTE} Continuing installation anyway..." 2>&1 | tee -a "$LOG"
fi

# Install build dependencies
echo "${INFO} Installing VMware Tools build dependencies..." 2>&1 | tee -a "$LOG"
for PKG1 in "${vmware_build_deps[@]}"; do
  install_package "$PKG1" 2>&1 | tee -a "$LOG"
  if [ $? -ne 0 ]; then
    echo -e "\e[1A\e[K${ERROR} - $PKG1 Package installation failed, Please check the installation logs"
    exit 1
  fi
done

# Clean up any existing installations
echo "${INFO} Cleaning up previous VMware Tools installations..." 2>&1 | tee -a "$LOG"
rm -rf vmware-tools 2>&1 | tee -a "$LOG"
rm -rf ~/open-vm-tools 2>&1 | tee -a "$LOG"

# Clone VMware Tools repository
echo "${INFO} Cloning VMware Tools repository..." 2>&1 | tee -a "$LOG"
if git clone https://github.com/daimaou92/install-arch-vmwarefusion-techpreview.git vmware-tools 2>&1 | tee -a "$LOG"; then
    echo "${OK} Successfully cloned VMware Tools repository" 2>&1 | tee -a "$LOG"
else
    echo "${ERROR} Failed to clone VMware Tools repository" 2>&1 | tee -a "$LOG"
    exit 1
fi

# Build and install Open VMware Tools
echo "${INFO} Building and installing Open VMware Tools..." 2>&1 | tee -a "$LOG"
if [ -d "vmware-tools/after/openvmtools" ]; then
    cd vmware-tools/after/openvmtools || { echo "${ERROR} Failed to change to openvmtools directory" 2>&1 | tee -a "$LOG"; exit 1; }
    
    if [ -f "build.sh" ]; then
        echo "${INFO} Executing VMware Tools build script..." 2>&1 | tee -a "$LOG"
        chmod +x build.sh
        if sh build.sh 2>&1 | tee -a "$LOG"; then
            echo "${OK} VMware Tools build completed successfully" 2>&1 | tee -a "$LOG"
        else
            echo "${ERROR} VMware Tools build failed" 2>&1 | tee -a "$LOG"
            exit 1
        fi
    else
        echo "${ERROR} build.sh script not found in openvmtools directory" 2>&1 | tee -a "$LOG"
        exit 1
    fi
else
    echo "${ERROR} openvmtools directory not found in cloned repository" 2>&1 | tee -a "$LOG"
    exit 1
fi

# Return to parent directory
cd "$PARENT_DIR" || { echo "${ERROR} Failed to return to parent directory" 2>&1 | tee -a "$LOG"; exit 1; }

echo "${OK} Open VMware Tools installation completed!" 2>&1 | tee -a "$LOG"
echo "${INFO} VMware Tools features installed:" 2>&1 | tee -a "$LOG"
echo "  - 🖥️  Enhanced display resolution and scaling" 2>&1 | tee -a "$LOG"
echo "  - 📋 Clipboard sharing between host and guest" 2>&1 | tee -a "$LOG"
echo "  - 📁 Drag-and-drop file sharing" 2>&1 | tee -a "$LOG"
echo "  - ⏰ Time synchronization with host" 2>&1 | tee -a "$LOG"
echo "  - 🔧 VM hardware integration" 2>&1 | tee -a "$LOG"
echo "" 2>&1 | tee -a "$LOG"
echo "${WARNING} A system reboot is required to complete the installation." 2>&1 | tee -a "$LOG"
echo "${NOTE} After reboot, VMware Tools services will start automatically." 2>&1 | tee -a "$LOG"
echo "" 2>&1 | tee -a "$LOG"
echo "${NOTE} 🍎 macOS + VMware Fusion clipboard sharing setup:" 2>&1 | tee -a "$LOG"
echo "  1. In VMware Fusion: VM → Settings → Sharing" 2>&1 | tee -a "$LOG"
echo "  2. Enable: ✅ Enable Shared Clipboard" 2>&1 | tee -a "$LOG"
echo "  3. Enable: ✅ Enable Drag and Drop" 2>&1 | tee -a "$LOG"
echo "  4. Reboot the VM after enabling these settings" 2>&1 | tee -a "$LOG"
echo "  5. Test: Copy text on macOS → Paste in Linux VM (Ctrl+V)" 2>&1 | tee -a "$LOG"
echo "  6. Test: Copy text in Linux VM → Paste on macOS (Cmd+V)" 2>&1 | tee -a "$LOG"
echo "" 2>&1 | tee -a "$LOG"
echo "${NOTE} 🐧 Linux VM clipboard commands:" 2>&1 | tee -a "$LOG"
echo "  • Copy to clipboard: echo 'text' | wl-copy" 2>&1 | tee -a "$LOG"
echo "  • Paste from clipboard: wl-paste" 2>&1 | tee -a "$LOG"
echo "  • Check VMware Tools status: systemctl status vmtoolsd" 2>&1 | tee -a "$LOG"
echo "" 2>&1 | tee -a "$LOG"

# Ask user if they want to reboot now
printf "%s - ${SKY_BLUE}Would you like to reboot now?${RESET} (y/N): " "${NOTE}"
read -r reboot_choice

case "$reboot_choice" in
    [Yy]|[Yy][Ee][Ss])
        echo "${INFO} Rebooting system to complete VMware Tools installation..." 2>&1 | tee -a "$LOG"
        sudo reboot
        ;;
    *)
        echo "${NOTE} Reboot skipped. Please reboot manually to complete installation." 2>&1 | tee -a "$LOG"
        echo "${NOTE} Run: sudo reboot" 2>&1 | tee -a "$LOG"
        ;;
esac

printf "\n%.0s" {1..2}
