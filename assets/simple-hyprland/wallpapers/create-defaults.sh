#!/bin/bash
# Script to create default wallpapers for Simple Hyprland Config

WALLPAPER_DIR="$HOME/.config/swww/wallpapers"
mkdir -p "$WALLPAPER_DIR"

echo "🎨 Creating default wallpapers..."

# Function to create solid color wallpaper
create_solid_wallpaper() {
    local name="$1"
    local color="$2"
    local file="$WALLPAPER_DIR/$name.png"
    
    if command -v convert >/dev/null; then
        convert -size 1920x1080 xc:"$color" "$file" 2>/dev/null && echo "✅ Created $name.png"
    elif command -v magick >/dev/null; then
        magick -size 1920x1080 xc:"$color" "$file" 2>/dev/null && echo "✅ Created $name.png"
    else
        echo "❌ ImageMagick not available, cannot create $name.png"
        return 1
    fi
}

# Function to create gradient wallpaper
create_gradient_wallpaper() {
    local name="$1" 
    local color1="$2"
    local color2="$3"
    local file="$WALLPAPER_DIR/$name.png"
    
    if command -v convert >/dev/null; then
        convert -size 1920x1080 gradient:"$color1"-"$color2" "$file" 2>/dev/null && echo "✅ Created $name.png"
    elif command -v magick >/dev/null; then
        magick -size 1920x1080 gradient:"$color1"-"$color2" "$file" 2>/dev/null && echo "✅ Created $name.png"
    else
        echo "❌ ImageMagick not available, cannot create $name.png"
        return 1
    fi
}

# Create default wallpapers
create_solid_wallpaper "default" "#1e1e2e"
create_solid_wallpaper "arch-dark" "#0f0f23"
create_solid_wallpaper "catppuccin-mocha" "#1e1e2e"
create_solid_wallpaper "nord-dark" "#2e3440" 
create_solid_wallpaper "github-dark" "#0d1117"
create_gradient_wallpaper "minimal-blue" "#1e1e2e" "#89b4fa"
create_gradient_wallpaper "sunset" "#fab387" "#f38ba8"

# Set default wallpaper link
if [ -f "$WALLPAPER_DIR/default.png" ]; then
    ln -sf "$WALLPAPER_DIR/default.png" "$HOME/.config/swww/wall.png"
    echo "🔗 Set default.png as active wallpaper"
fi

echo "🎉 Wallpaper setup complete!"
echo "📁 Wallpapers location: $WALLPAPER_DIR"
echo "🔄 To change wallpaper: swww img $WALLPAPER_DIR/wallpaper-name.png"