#!/bin/bash
# Simple wallpaper setup - always works

WALLPAPER_DIR="$HOME/.config/swww/wallpapers"
mkdir -p "$WALLPAPER_DIR"

echo "🎨 Setting up simple wallpaper system..."

# Create a simple fallback wallpaper if ImageMagick is available
echo "🔗 Creating default fallback wallpaper..."
if command -v convert >/dev/null 2>&1; then
    convert -size 1920x1080 xc:"#1e1e2e" "$WALLPAPER_DIR/fallback.png" 2>/dev/null
    ln -sf "$WALLPAPER_DIR/fallback.png" "$HOME/.config/swww/wall.png"
    echo "✅ Created fallback wallpaper: $WALLPAPER_DIR/fallback.png"
elif command -v magick >/dev/null 2>&1; then
    magick -size 1920x1080 xc:"#1e1e2e" "$WALLPAPER_DIR/fallback.png" 2>/dev/null
    ln -sf "$WALLPAPER_DIR/fallback.png" "$HOME/.config/swww/wall.png"
    echo "✅ Created fallback wallpaper: $WALLPAPER_DIR/fallback.png"
else
    echo "⚠️  ImageMagick not found - wallpaper-init.sh will handle fallback"
    touch "$HOME/.config/swww/wall.png.missing" # Marker file
fi

echo "✅ Simple wallpaper setup complete!"
echo "📝 Wallpaper will use solid color fallback: #1e1e2e"
echo "🔄 To add custom wallpapers: copy .png files to $WALLPAPER_DIR"
echo "🎨 To change wallpaper: swww img /path/to/wallpaper.png"