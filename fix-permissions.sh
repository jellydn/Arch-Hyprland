#!/bin/bash
# Fix execute permissions for scripts that need them

echo "Setting execute permissions for wallpaper scripts..."

chmod +x assets/simple-hyprland/scripts/wallpaper-chooser.sh
chmod +x assets/simple-hyprland/wallpapers/create-defaults.sh

echo "✅ Permissions updated successfully"
echo "📝 Don't forget to commit these permission changes!"