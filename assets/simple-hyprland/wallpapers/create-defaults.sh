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
    
    if command -v convert >/dev/null 2>&1; then
        if convert -size 1920x1080 xc:"$color" "$file" 2>/dev/null; then
            echo "✅ Created $name.png"
            return 0
        fi
    elif command -v magick >/dev/null 2>&1; then
        if magick -size 1920x1080 xc:"$color" "$file" 2>/dev/null; then
            echo "✅ Created $name.png" 
            return 0
        fi
    fi
    
    echo "❌ Cannot create $name.png (ImageMagick not available or failed)"
    return 1
}

# Function to create gradient wallpaper
create_gradient_wallpaper() {
    local name="$1" 
    local color1="$2"
    local color2="$3"
    local file="$WALLPAPER_DIR/$name.png"
    
    if command -v convert >/dev/null 2>&1; then
        if convert -size 1920x1080 gradient:"$color1"-"$color2" "$file" 2>/dev/null; then
            echo "✅ Created $name.png"
            return 0
        fi
    elif command -v magick >/dev/null 2>&1; then
        if magick -size 1920x1080 gradient:"$color1"-"$color2" "$file" 2>/dev/null; then
            echo "✅ Created $name.png"
            return 0
        fi
    fi
    
    echo "❌ Cannot create $name.png (ImageMagick not available or failed)"
    return 1
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
created_count=0
for wallpaper in "$WALLPAPER_DIR"/*.png; do
    if [ -f "$wallpaper" ] && [ -s "$wallpaper" ]; then
        ((created_count++))
    fi
done

if [ $created_count -gt 0 ]; then
    # Find the first valid wallpaper to set as default
    for wallpaper in "$WALLPAPER_DIR"/{default,arch-dark,catppuccin-mocha,nord-dark}.png; do
        if [ -f "$wallpaper" ] && [ -s "$wallpaper" ]; then
            ln -sf "$wallpaper" "$HOME/.config/swww/wall.png"
            echo "🔗 Set $(basename "$wallpaper") as active wallpaper"
            break
        fi
    done
    echo "🎉 Wallpaper setup complete! Created $created_count wallpapers"
else
    echo "⚠️ No wallpapers were created successfully"
    echo "💡 Install ImageMagick to create default wallpapers: sudo pacman -S imagemagick"
    echo "📝 Or manually copy wallpaper files to: $WALLPAPER_DIR"
fi

echo "📁 Wallpapers location: $WALLPAPER_DIR"
echo "🔄 To change wallpaper: swww img $WALLPAPER_DIR/wallpaper-name.png"