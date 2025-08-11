# 💫 Simple KooL Hyprland Configuration

A simplified, tiling-focused version of [KooL's Hyprland dotfiles](https://github.com/JaKooLit/Hyprland-Dots) designed for:
- **🚀 Easy setup** - Single configuration file
- **⚡ Tiling power** - Embraces Hyprland's strength  
- **🦶 VM-friendly** - Uses Foot terminal, optimized for VMs
- **🎨 Beautiful** - KooL styling with catppuccin colors

## 🔧 Installation

From the main Arch-Hyprland directory:

```bash
# Install simple config only
./install.sh --simple-config

# Or full setup with simple config
./install.sh --auto --simple-config --gtk-themes --bluetooth --thunar --foot --firefox
```

## ⚡ Key Features

**Tiling-First Approach:**
- Smart tiling for all main applications
- Only utilities (volume control, network manager) float
- Advanced tiling keybindings for power users

**VM Optimizations:**
- Environment variables for software rendering
- Optimized animations and effects
- Lightweight Foot terminal instead of GPU-heavy alternatives

**Workspace Organization:**
- Workspace 1: Terminals (foot)
- Workspace 2: Browsers (firefox) 
- Workspace 3: File managers (thunar)
- Workspace 4: Code editors

## 🎹 Essential Keybindings

| Key Combination | Action |
|---|---|
| `Super + Return` | Open terminal (foot) |
| `Super + B` | Open browser (firefox) |
| `Super + D` | Application launcher |
| `Super + Q` | Close window |
| `Super + J` | Toggle split direction |
| `Super + V` | Toggle floating/tiled |
| `Super + F` | Fullscreen |
| `Super + Shift + Arrows` | Move windows |
| `Super + Ctrl + Arrows` | Resize windows |
| `Super + 1-9` | Switch workspaces |
| `Super + Shift + 1-9` | Move window to workspace |
| `Super + Grave` | Toggle special workspace |

## 📝 Customization Guide

### Quick Edits

The configuration file is located at: `~/.config/hypr/hyprland.conf`

**Change terminal:**
```bash
$term = foot    # Change to: kitty, alacritty, ghostty
```

**Change browser:**
```bash
$browser = firefox    # Change to: brave, chromium
```

**Adjust window gaps:**
```bash
gaps_in = 3     # Inner gaps between windows
gaps_out = 8    # Outer gaps from screen edges  
```

**Change border colors:**
```bash
col.active_border = rgba(ca9ee6ff) rgba(f2d5cfff) 45deg
col.inactive_border = rgba(6c7086ff)
```

### Adding Custom Keybindings

Add new keybindings anywhere in the keybinding section:

```bash
# Custom keybinding example
bind = $mainMod, Space, exec, rofi -show drun
bind = $mainMod SHIFT, S, exec, grim -g "$(slurp)"
```

### Advanced Tiling Customization

**Modify split ratio:**
```bash
dwindle {
    default_split_ratio = 1.2    # 1.0 = equal, >1.0 = first window larger
}
```

**Change when gaps appear:**
```bash
no_gaps_when_only = 1    # 1 = no gaps when only one window
```

## 🔄 Reloading Configuration

After making changes:
1. **Live reload**: Press `Super + Shift + R`
2. **Full restart**: Log out and back in
3. **Test**: Open terminal (`Super + Return`) to verify

## 🌐 Advanced Customization

For more advanced features, refer to:
- [Hyprland Wiki](https://wiki.hyprland.org/) - Official documentation
- [KooL Dotfiles](https://github.com/JaKooLit/Hyprland-Dots) - Full featured version
- [Catppuccin Colors](https://github.com/catppuccin/catppuccin) - Color scheme reference

## 🔧 Re-installation

To reset or reinstall the simple config:

```bash
# From install-scripts directory
./simple-config.sh

# Or from main directory  
./install.sh --simple-config
```

This will overwrite your current `~/.config/hypr/hyprland.conf` with the default simple config.

## 🎯 Philosophy

This configuration embraces **Hyprland's core strength: dynamic tiling**. Unlike traditional floating window managers, tiling maximizes screen real estate and provides keyboard-driven efficiency. The simple config removes complexity while preserving the power that makes Hyprland special.

**Happy tiling! 🪟✨**