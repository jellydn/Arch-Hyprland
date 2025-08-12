# Default Wallpapers for Simple Hyprland Config

This directory contains default wallpapers for the Simple Hyprland configuration.

## Included Wallpapers

- **arch-dark.png** - Dark Arch Linux themed wallpaper
- **catppuccin-mocha.png** - Catppuccin Mocha themed wallpaper  
- **minimal-blue.png** - Minimal blue gradient wallpaper
- **default.png** - Simple dark solid color wallpaper

## Usage

Wallpapers are automatically installed to `~/.config/swww/wallpapers/` during installation.
The default wallpaper is set to `default.png` but can be changed by:

1. **Using swww command:**
   ```bash
   swww img ~/.config/swww/wallpapers/arch-dark.png
   ```

2. **Edit Hyprland config:**
   Edit `~/.config/hypr/hyprland.conf` and change:
   ```
   exec-once = swww img ~/.config/swww/wallpapers/your-wallpaper.png
   ```

3. **Add your own wallpapers:**
   Place them in `~/.config/swww/wallpapers/` and use swww to set them.

## Creating Custom Wallpapers

You can create solid color wallpapers using ImageMagick:
```bash
# Create a solid color wallpaper
convert -size 1920x1080 xc:"#color" wallpaper.png

# Examples:
convert -size 1920x1080 xc:"#1e1e2e" dark-purple.png
convert -size 1920x1080 xc:"#2e3440" nord-dark.png
convert -size 1920x1080 xc:"#0d1117" github-dark.png
```