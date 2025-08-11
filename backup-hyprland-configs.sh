#!/bin/bash
# 💫 https://github.com/jellydn/Arch-Hyprland 💫 #
# Standalone backup script for Hyprland configurations #

## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##

# Set colors for output
OK="\033[32m[OK]\033[0m"
ERROR="\033[31m[ERROR]\033[0m" 
NOTE="\033[33m[NOTE]\033[0m"
INFO="\033[34m[INFO]\033[0m"

echo -e "${INFO} 🔄 Backup script for Hyprland configurations"
echo -e "${INFO} This will backup hypr, waybar, rofi, wlogout, and foot configs"
echo ""

# Create backup timestamp
BACKUP_TIME=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="$HOME/.config/hypr/backups/manual_$BACKUP_TIME"

echo -e "${INFO} Creating backup directory: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

backed_up_anything=false

# Backup Hyprland configuration
if [ -f "$HOME/.config/hypr/hyprland.conf" ]; then
    cp "$HOME/.config/hypr/hyprland.conf" "$BACKUP_DIR/" 2>/dev/null
    echo -e "${OK} Hyprland config backed up"
    backed_up_anything=true
fi

# Backup entire hypr directory
if [ -d "$HOME/.config/hypr" ] && [ "$(find "$HOME/.config/hypr" -mindepth 1 -maxdepth 1 -type f | wc -l)" -gt 0 ]; then
    mkdir -p "$BACKUP_DIR/hypr_full"
    cp -r "$HOME/.config/hypr"/* "$BACKUP_DIR/hypr_full/" 2>/dev/null
    echo -e "${OK} Full hypr directory backed up"
    backed_up_anything=true
fi

# Backup Waybar configuration
if [ -d "$HOME/.config/waybar" ] && [ "$(ls -A "$HOME/.config/waybar" 2>/dev/null)" ]; then
    mkdir -p "$BACKUP_DIR/waybar"
    cp -r "$HOME/.config/waybar"/* "$BACKUP_DIR/waybar/" 2>/dev/null
    echo -e "${OK} Waybar config backed up"
    backed_up_anything=true
else
    echo -e "${NOTE} No waybar config found to backup"
fi

# Backup Rofi configuration
if [ -d "$HOME/.config/rofi" ] && [ "$(ls -A "$HOME/.config/rofi" 2>/dev/null)" ]; then
    mkdir -p "$BACKUP_DIR/rofi"
    cp -r "$HOME/.config/rofi"/* "$BACKUP_DIR/rofi/" 2>/dev/null
    echo -e "${OK} Rofi config backed up"
    backed_up_anything=true
else
    echo -e "${NOTE} No rofi config found to backup"
fi

# Backup Wlogout configuration
if [ -d "$HOME/.config/wlogout" ] && [ "$(ls -A "$HOME/.config/wlogout" 2>/dev/null)" ]; then
    mkdir -p "$BACKUP_DIR/wlogout"
    cp -r "$HOME/.config/wlogout"/* "$BACKUP_DIR/wlogout/" 2>/dev/null
    echo -e "${OK} Wlogout config backed up"
    backed_up_anything=true
else
    echo -e "${NOTE} No wlogout config found to backup"
fi

# Backup Foot configuration
if [ -f "$HOME/.config/foot/foot.ini" ]; then
    cp "$HOME/.config/foot/foot.ini" "$BACKUP_DIR/" 2>/dev/null
    echo -e "${OK} Foot config backed up"
    backed_up_anything=true
else
    echo -e "${NOTE} No foot config found to backup"
fi

# Summary
if [ "$backed_up_anything" = true ]; then
    echo ""
    echo -e "${OK} ✅ Backup completed successfully!"
    echo -e "${INFO} 📁 Backup location: $BACKUP_DIR"
    echo ""
    echo -e "${INFO} Backup contents:"
    if command -v tree >/dev/null; then
        tree "$BACKUP_DIR" | sed 's/^/  /'
    else
        find "$BACKUP_DIR" -type f | sed 's/^/  /'
    fi
    echo ""
    echo -e "${NOTE} 🔄 To restore from this backup:"
    echo "  cp $BACKUP_DIR/hyprland.conf ~/.config/hypr/ 2>/dev/null || true"
    echo "  cp -r $BACKUP_DIR/hypr_full/* ~/.config/hypr/ 2>/dev/null || true"
    echo "  cp -r $BACKUP_DIR/waybar/* ~/.config/waybar/ 2>/dev/null || true"
    echo "  cp -r $BACKUP_DIR/rofi/* ~/.config/rofi/ 2>/dev/null || true"
    echo "  cp -r $BACKUP_DIR/wlogout/* ~/.config/wlogout/ 2>/dev/null || true"
    echo "  cp $BACKUP_DIR/foot.ini ~/.config/foot/ 2>/dev/null || true"
    echo "  # Then reload: Super + Shift + R"
    echo ""
    echo -e "${NOTE} 🗑️  To remove this backup:"
    echo "  rm -rf $BACKUP_DIR"
else
    echo -e "${NOTE} No configurations found to backup"
fi

echo ""
echo -e "${INFO} 💡 Run this script anytime before making configuration changes!"