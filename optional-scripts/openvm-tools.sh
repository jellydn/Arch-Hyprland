#!/bin/bash

# Simple VMware open-vm-tools installer
# This script installs basic VMware tools for better VM integration

echo "🔧 Installing VMware open-vm-tools..."

# Install basic VMware packages
echo "📦 Installing packages..."
sudo pacman -S open-vm-tools xf86-video-vmware xf86-input-vmmouse --noconfirm

# Enable and start vmtoolsd service
echo "⚙️  Enabling VMware tools service..."
sudo systemctl enable vmtoolsd.service
sudo systemctl start vmtoolsd.service

echo "✅ VMware tools installation completed!"
echo "📝 Features enabled:"
echo "   • Clipboard sharing"
echo "   • Drag and drop"
echo "   • Dynamic resolution"
echo "   • Time synchronization"
echo ""
echo "💡 Tip: Restart your VM for full integration"
echo "🔍 Check service status: systemctl status vmtoolsd"