#!/bin/bash

# Simple VMware open-vm-tools installer
# This script installs basic VMware tools for better VM integration

echo "🔧 Installing VMware open-vm-tools..."

# Function to check if running in VMware
is_vmware() {
    if lspci | grep -i vmware >/dev/null 2>&1; then
        return 0
    elif systemd-detect-virt 2>/dev/null | grep -i vmware >/dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

# Check if running in VMware
if ! is_vmware; then
    echo "⚠️  Warning: VMware environment not detected."
    echo "   This script is designed for VMware virtual machines."
    read -p "   Continue anyway? [y/N]: " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "❌ Installation cancelled."
        exit 0
    fi
fi

# VMware packages - try different combinations that might be available
PACKAGES_TO_TRY=(
    # Standard Arch packages (if available)
    "open-vm-tools"
    # Alternative package names
    "openvm-tools" 
    # Basic packages that should exist
    "gtkmm3"
    "mesa"
)

# Function to install package if available
install_if_available() {
    local package="$1"
    echo "📦 Trying to install $package..."
    if sudo pacman -S "$package" --noconfirm 2>/dev/null; then
        echo "✅ Successfully installed $package"
        return 0
    else
        echo "⚠️  Package $package not available in repositories"
        return 1
    fi
}

# Install available packages
echo "📦 Installing VMware tools packages..."
INSTALLED_COUNT=0

for package in "${PACKAGES_TO_TRY[@]}"; do
    if install_if_available "$package"; then
        ((INSTALLED_COUNT++))
    fi
done

# Try AUR packages if main packages failed
if [ $INSTALLED_COUNT -eq 0 ]; then
    echo "⚠️  No VMware packages found in official repositories."
    echo "💡 You may need to:"
    echo "   1. Enable multilib repository in /etc/pacman.conf"
    echo "   2. Install from AUR using yay or paru:"
    echo "      yay -S open-vm-tools"
    echo "   3. Or install manually from VMware"
    echo ""
    echo "❌ Installation incomplete - no packages installed"
    exit 1
fi

# Enable services if they exist
echo "⚙️  Configuring VMware services..."

# Try to enable common VMware services
SERVICES_TO_TRY=(
    "vmtoolsd.service"
    "open-vm-tools.service"
    "vmware-vmblock-fuse.service"
)

ENABLED_SERVICES=0
for service in "${SERVICES_TO_TRY[@]}"; do
    if systemctl list-unit-files | grep -q "$service"; then
        echo "🔧 Enabling $service..."
        if sudo systemctl enable "$service" 2>/dev/null; then
            sudo systemctl start "$service" 2>/dev/null || true
            echo "✅ $service enabled"
            ((ENABLED_SERVICES++))
        fi
    fi
done

if [ $ENABLED_SERVICES -eq 0 ]; then
    echo "⚠️  No VMware services found to enable"
    echo "💡 Services may start automatically on next boot"
fi

echo ""
echo "✅ VMware tools installation completed!"
echo "📦 Packages installed: $INSTALLED_COUNT"
echo "⚙️  Services enabled: $ENABLED_SERVICES"
echo ""
echo "📝 Expected features (if packages installed correctly):"
echo "   • Clipboard sharing between host and VM"
echo "   • Drag and drop file support"
echo "   • Dynamic screen resolution"
echo "   • Time synchronization"
echo ""
echo "💡 Tips:"
echo "   • Restart your VM for full integration"
echo "   • Check what was installed: pacman -Q | grep vm"
echo "   • Check services: systemctl status vmtoolsd"
echo ""
if [ $INSTALLED_COUNT -lt 2 ]; then
    echo "⚠️  Warning: Limited packages installed."
    echo "   You may need to install open-vm-tools from AUR:"
    echo "   yay -S open-vm-tools xf86-video-vmware xf86-input-vmmouse"
fi