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

**Complete Desktop Environment:**
- **Waybar** - Enhanced status bar with date/time, detailed network info, volume control, battery
- **Rofi** - Modern application launcher with search and file browsing
- **Wlogout** - Elegant power menu with lock, logout, shutdown, reboot, suspend
- **VM Auto-scaling** - Automatically detects VMware/VirtualBox and adjusts display scaling

**Tiling-First Approach:**
- Smart tiling for all main applications
- Only utilities (volume control, network manager) float
- Advanced tiling keybindings for power users

**VM Optimizations:**
- Auto-detects VMware, VirtualBox, UTM, Parallels, and QEMU/KVM
- Automatically applies optimal display scaling (1.25x for 1080p, 1.5x for 1440p, etc.)
- Environment variables for software rendering and cursor compatibility
- Optimized animations and effects for better VM performance

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
| `Super + D` | Application launcher (rofi) |
| `Super + R` | Run command (rofi) |
| `Super + Q` | Close window |
| `Super + J` | Toggle split direction |
| `Super + V` | Toggle floating/tiled |
| `Super + F` | Fullscreen |
| `Super + Shift + Arrows` | Move windows |
| `Super + Ctrl + Arrows` | Resize windows |
| `Super + 1-9` | Switch workspaces |
| `Super + Shift + 1-9` | Move window to workspace |
| `Super + Grave` | Toggle special workspace |

## 🧩 Included Components

### Waybar Status Bar
- **Location**: Top of screen with rounded corners
- **Left**: OS logo (app launcher), workspaces, window title
- **Center**: Time display and date with enhanced tooltips
- **Right**: System tray, network with SSID/details, volume control, battery, power menu
- **Styling**: Catppuccin Mocha theme with VM optimizations

**Waybar Interactions:**
- Click OS logo → Launch rofi
- Click time → Switch 12/24 hour format
- Click date → Shows current date
- Click network → Open network manager, right-click for terminal UI
- Click volume → Open pavucontrol, scroll to adjust volume
- Click power → Open wlogout power menu

### Rofi Application Launcher  
- **Style**: Clean, modern with blur effects
- **Modes**: Apps, Run commands, File browser
- **Features**: Icon support, search, mouse/keyboard navigation
- **Theme**: Simple KooL theme matching Hyprland colors

**Rofi Usage:**
- `Super + D` → App launcher
- `Super + R` → Run commands
- Type to search applications
- Arrow keys or mouse to navigate

### Wlogout Power Menu
- **Style**: Clean interface with emoji-based icons for VM compatibility
- **Actions**: Lock, Logout, Shutdown, Reboot, Suspend
- **Features**: Keyboard shortcuts, hover effects, Catppuccin Mocha theme

**Wlogout Usage:**
- Access via waybar power button or `Super+Shift+Q`
- `L` → Lock screen (hyprlock)
- `E` → Logout from Hyprland
- `S` → Shutdown system
- `R` → Reboot system
- `U` → Suspend to RAM

### VM Auto-Scaling
- **Detection**: Automatically identifies VM type on startup
- **Supported VMs**: VMware, VirtualBox, UTM, Parallels, QEMU/KVM
- **Scaling**: Resolution-aware scaling (1.25x for 1080p, 1.5x for 1440p, 1.75x for 4K+)
- **Optimizations**: VM-specific environment variables and cursor fixes

**Manual Rescaling:**
```bash
# Regenerate VM configuration
~/.config/hypr/scripts/vm-scale.sh
# Then reload: Super + Shift + R
```

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

## 📁 File Structure

When installed, the simple config creates this structure:

```
~/.config/hypr/
├── hyprland.conf          # Main Hyprland configuration
├── vm-monitor.conf        # Auto-generated VM scaling config
├── scripts/
│   └── vm-scale.sh        # VM detection and scaling script
├── waybar/
│   ├── config.jsonc       # Waybar configuration with enhanced modules
│   └── style.css          # Waybar styling (Catppuccin Mocha)
├── rofi/
│   ├── config.rasi        # Rofi main configuration
│   ├── fonts.rasi         # Font settings
│   └── simple-kool.rasi   # Rofi theme
└── wlogout/
    ├── layout             # Wlogout button layout and actions
    └── style.css          # Wlogout styling (Catppuccin Mocha)
```

## 🔄 Reloading Configuration

After making changes:
1. **Live reload**: Press `Super + Shift + R`
2. **Full restart**: Log out and back in
3. **Test**: Open terminal (`Super + Return`) to verify

**Component-specific reloading:**
- **Waybar**: `pkill waybar && waybar &`
- **VM scaling**: Run `~/.config/hypr/scripts/vm-scale.sh` then `Super + Shift + R`

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