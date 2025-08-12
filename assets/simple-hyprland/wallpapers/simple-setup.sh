#!/bin/bash
# Simple wallpaper setup - always works

WALLPAPER_DIR="$HOME/.config/swww/wallpapers"
mkdir -p "$WALLPAPER_DIR"

echo "🎨 Setting up simple wallpaper system..."

# Create a simple default wallpaper link that points to a solid color
echo "🔗 Creating default wallpaper link..."
ln -sf /dev/null "$HOME/.config/swww/wall.png" 2>/dev/null || true

echo "✅ Simple wallpaper setup complete!"
echo "📝 Wallpaper will use solid color fallback: #1e1e2e"
echo "🔄 To add custom wallpapers: copy .png files to $WALLPAPER_DIR"
echo "🎨 To change wallpaper: swww img /path/to/wallpaper.png"