#!/bin/bash
# 💫 https://github.com/jellydn/Arch-Hyprland 💫 #
# Backup Configuration Helper Script #

## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##

# Function to create backups of hypr, rofi, and waybar configurations
create_config_backup() {
    local backup_reason="${1:-install}"
    
    # Create backup timestamp
    local BACKUP_TIME=$(date +%Y%m%d_%H%M%S)
    local BACKUP_DIR="$HOME/.config/hypr/backups/${backup_reason}_$BACKUP_TIME"
    
    echo "${INFO} Creating backup of existing configurations..." 2>&1 | tee -a "$LOG"
    
    local backed_up_anything=false
    
    # Backup Hyprland configuration
    if [ -f "$HOME/.config/hypr/hyprland.conf" ]; then
        mkdir -p "$BACKUP_DIR"
        cp "$HOME/.config/hypr/hyprland.conf" "$BACKUP_DIR/" 2>/dev/null || true
        echo "${NOTE} Hyprland config backed up to: $BACKUP_DIR/hyprland.conf" 2>&1 | tee -a "$LOG"
        backed_up_anything=true
    fi
    
    # Backup entire hypr directory if it has other files
    if [ -d "$HOME/.config/hypr" ] && [ "$(find "$HOME/.config/hypr" -mindepth 1 -maxdepth 1 -type f | wc -l)" -gt 1 ]; then
        mkdir -p "$BACKUP_DIR/hypr_full"
        cp -r "$HOME/.config/hypr"/* "$BACKUP_DIR/hypr_full/" 2>/dev/null || true
        echo "${NOTE} Full hypr directory backed up to: $BACKUP_DIR/hypr_full/" 2>&1 | tee -a "$LOG"
        backed_up_anything=true
    fi
    
    # Backup Waybar configuration
    if [ -d "$HOME/.config/waybar" ] && [ "$(ls -A "$HOME/.config/waybar" 2>/dev/null)" ]; then
        mkdir -p "$BACKUP_DIR/waybar"
        cp -r "$HOME/.config/waybar"/* "$BACKUP_DIR/waybar/" 2>/dev/null || true
        echo "${NOTE} Waybar config backed up to: $BACKUP_DIR/waybar/" 2>&1 | tee -a "$LOG"
        backed_up_anything=true
    else
        echo "${NOTE} No existing waybar config to backup" 2>&1 | tee -a "$LOG"
    fi
    
    # Backup Rofi configuration
    if [ -d "$HOME/.config/rofi" ] && [ "$(ls -A "$HOME/.config/rofi" 2>/dev/null)" ]; then
        mkdir -p "$BACKUP_DIR/rofi"
        cp -r "$HOME/.config/rofi"/* "$BACKUP_DIR/rofi/" 2>/dev/null || true
        echo "${NOTE} Rofi config backed up to: $BACKUP_DIR/rofi/" 2>&1 | tee -a "$LOG"
        backed_up_anything=true
    else
        echo "${NOTE} No existing rofi config to backup" 2>&1 | tee -a "$LOG"
    fi
    
    # Backup Wlogout configuration (if exists)
    if [ -d "$HOME/.config/wlogout" ] && [ "$(ls -A "$HOME/.config/wlogout" 2>/dev/null)" ]; then
        mkdir -p "$BACKUP_DIR/wlogout"
        cp -r "$HOME/.config/wlogout"/* "$BACKUP_DIR/wlogout/" 2>/dev/null || true
        echo "${NOTE} Wlogout config backed up to: $BACKUP_DIR/wlogout/" 2>&1 | tee -a "$LOG"
        backed_up_anything=true
    else
        echo "${NOTE} No existing wlogout config to backup" 2>&1 | tee -a "$LOG"
    fi
    
    # Backup Foot configuration (if exists)
    if [ -f "$HOME/.config/foot/foot.ini" ]; then
        mkdir -p "$BACKUP_DIR"
        cp "$HOME/.config/foot/foot.ini" "$BACKUP_DIR/" 2>/dev/null || true
        echo "${NOTE} Foot config backed up to: $BACKUP_DIR/foot.ini" 2>&1 | tee -a "$LOG"
        backed_up_anything=true
    else
        echo "${NOTE} No existing foot config to backup" 2>&1 | tee -a "$LOG"
    fi
    
    # Backup swww configuration (wallpaper system)
    if [ -d "$HOME/.config/swww" ] && [ "$(ls -A "$HOME/.config/swww" 2>/dev/null)" ]; then
        mkdir -p "$BACKUP_DIR/swww"
        cp -r "$HOME/.config/swww"/* "$BACKUP_DIR/swww/" 2>/dev/null || true
        echo "${NOTE} swww config backed up to: $BACKUP_DIR/swww/" 2>&1 | tee -a "$LOG"
        backed_up_anything=true
    else
        echo "${NOTE} No existing swww config to backup" 2>&1 | tee -a "$LOG"
    fi
    
    # Show backup summary if anything was backed up
    if [ "$backed_up_anything" = true ] && [ -d "$BACKUP_DIR" ]; then
        echo "" 2>&1 | tee -a "$LOG"
        echo "${OK} Backup completed successfully!" 2>&1 | tee -a "$LOG"
        echo "${INFO} Backup location: $BACKUP_DIR" 2>&1 | tee -a "$LOG"
        echo "${INFO} Backup contents:" 2>&1 | tee -a "$LOG"
        if command -v tree >/dev/null; then
            tree "$BACKUP_DIR" | sed 's/^/  /' 2>&1 | tee -a "$LOG"
        else
            find "$BACKUP_DIR" -type f | sed 's/^/  /' 2>&1 | tee -a "$LOG"
        fi
        echo "" 2>&1 | tee -a "$LOG"
        
        # Export backup directory for use in calling script
        export LAST_BACKUP_DIR="$BACKUP_DIR"
    else
        echo "${NOTE} No existing configurations found to backup" 2>&1 | tee -a "$LOG"
        export LAST_BACKUP_DIR=""
    fi
}

# Function to display rollback instructions
show_rollback_instructions() {
    local backup_dir="${1:-$LAST_BACKUP_DIR}"
    
    if [ -n "$backup_dir" ] && [ -d "$backup_dir" ]; then
        echo "${NOTE} 📦 BACKUP INFORMATION:" 2>&1 | tee -a "$LOG"
        echo "  Your previous configurations have been backed up to:" 2>&1 | tee -a "$LOG"
        echo "  $backup_dir" 2>&1 | tee -a "$LOG"
        echo "" 2>&1 | tee -a "$LOG"
        echo "  🔄 To rollback to previous config:" 2>&1 | tee -a "$LOG"
        echo "  # Restore hyprland config:" 2>&1 | tee -a "$LOG"
        echo "  cp $backup_dir/hyprland.conf ~/.config/hypr/ 2>/dev/null || true" 2>&1 | tee -a "$LOG"
        echo "  # Restore full hypr directory:" 2>&1 | tee -a "$LOG"
        echo "  cp -r $backup_dir/hypr_full/* ~/.config/hypr/ 2>/dev/null || true" 2>&1 | tee -a "$LOG"
        echo "  # Restore other configs:" 2>&1 | tee -a "$LOG"
        echo "  cp -r $backup_dir/waybar/* ~/.config/waybar/ 2>/dev/null || true" 2>&1 | tee -a "$LOG"
        echo "  cp -r $backup_dir/rofi/* ~/.config/rofi/ 2>/dev/null || true" 2>&1 | tee -a "$LOG"
        echo "  cp -r $backup_dir/wlogout/* ~/.config/wlogout/ 2>/dev/null || true" 2>&1 | tee -a "$LOG"
        echo "  cp $backup_dir/foot.ini ~/.config/foot/ 2>/dev/null || true" 2>&1 | tee -a "$LOG"
        echo "  # Then reload: Super + Shift + R" 2>&1 | tee -a "$LOG"
        echo "" 2>&1 | tee -a "$LOG"
        echo "  🗑️  To remove backup after testing:" 2>&1 | tee -a "$LOG"
        echo "  rm -rf $backup_dir" 2>&1 | tee -a "$LOG"
        echo "" 2>&1 | tee -a "$LOG"
    fi
}

# Function to create a simple backup script for users
create_user_backup_script() {
    local script_path="$HOME/.config/hypr/backup-configs.sh"
    
    cat > "$script_path" << 'EOF'
#!/bin/bash
# User-friendly backup script for Hyprland configurations
# Generated by Arch-Hyprland installer

echo "🔄 Creating backup of your Hyprland configurations..."

BACKUP_TIME=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="$HOME/.config/hypr/backups/manual_$BACKUP_TIME"

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Backup configurations
[ -f "$HOME/.config/hypr/hyprland.conf" ] && cp "$HOME/.config/hypr/hyprland.conf" "$BACKUP_DIR/"
[ -d "$HOME/.config/waybar" ] && cp -r "$HOME/.config/waybar" "$BACKUP_DIR/"
[ -d "$HOME/.config/rofi" ] && cp -r "$HOME/.config/rofi" "$BACKUP_DIR/"
[ -d "$HOME/.config/wlogout" ] && cp -r "$HOME/.config/wlogout" "$BACKUP_DIR/"
[ -f "$HOME/.config/foot/foot.ini" ] && cp "$HOME/.config/foot/foot.ini" "$BACKUP_DIR/"

echo "✅ Backup completed!"
echo "📁 Backup location: $BACKUP_DIR"
echo "🔄 To restore, copy files back from the backup directory"
EOF

    chmod +x "$script_path" 2>/dev/null || true
    echo "${INFO} User backup script created at: $script_path" 2>&1 | tee -a "$LOG"
}

# Function to clean old backups (keep only last 5)
cleanup_old_backups() {
    local backup_root="$HOME/.config/hypr/backups"
    
    if [ -d "$backup_root" ]; then
        # Count backups
        local backup_count=$(find "$backup_root" -maxdepth 1 -type d -name "*_*" | wc -l)
        
        if [ "$backup_count" -gt 5 ]; then
            echo "${INFO} Cleaning up old backups (keeping last 5)..." 2>&1 | tee -a "$LOG"
            # Remove oldest backups, keep newest 5
            find "$backup_root" -maxdepth 1 -type d -name "*_*" -printf '%T@ %p\n' | \
                sort -n | head -n -5 | cut -d' ' -f2- | \
                while read -r dir; do
                    echo "${NOTE} Removing old backup: $(basename "$dir")" 2>&1 | tee -a "$LOG"
                    rm -rf "$dir"
                done
        fi
    fi
}