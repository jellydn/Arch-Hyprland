# Rofi Configuration

Standard rofi configuration files for the KooL Hyprland setup.

## Usage

Copy the theme files to your rofi config directory:

```bash
# Create rofi config directory
mkdir -p ~/.config/rofi

# Copy the theme
cp assets/rofi/simple-kool.rasi ~/.config/rofi/

# Or copy all rofi configs from simple-hyprland
cp assets/simple-hyprland/rofi/* ~/.config/rofi/
```

## Theme Features

- **simple-kool.rasi**: Main theme with Catppuccin Mocha colors
- VM-optimized performance settings
- Modern layout with icons and proper styling
- 2-column application layout for better space usage

## Integration

The simple hyprland configuration automatically uses this theme:
- `Super + D`: Application launcher
- `Super + R`: Run command prompt
- Waybar OS logo click: Application launcher

All rofi configurations follow the standard `~/.config/rofi/` directory structure.