# 💫 KooL-Optimized Hyprland Configuration

A **performance-optimized Hyprland configuration** based on [JaKooLit's Hyprland-Dots](https://github.com/JaKooLit/Hyprland-Dots) designed for:
- **⚡ VM Performance** - No animations, minimal blur, optimized for VMware/VirtualBox
- **🏢 Professional Desktop** - Complete KooL-inspired desktop environment
- **🎨 Beautiful Styling** - Catppuccin Mocha colors with KooL's aesthetic
- **🦶 VM-Optimized Terminal** - Foot with Fish shell for speed and usability
- **🔧 Complete Stack** - Waybar, Rofi, Wlogout, Which-Key helper system

## 🔧 Installation

From the main Arch-Hyprland directory:

```bash
# Install KooL-optimized config only
./install-scripts/simple-config.sh

# Or full setup with KooL-optimized config
./install.sh --auto --gtk-themes --bluetooth --thunar --foot --firefox
```

## ⚡ Key Features

**🚫 Performance-First Design:**
- **NO ANIMATIONS** - Maximum VM performance, instant window operations
- **Minimal Blur** - Lightweight effects optimized for virtual machines
- **Efficient Rendering** - VM-specific optimizations for VMware/VirtualBox
- **Fast Startup** - Streamlined autostart applications

**🏢 Complete KooL Desktop Environment:**
- **Waybar** - Professional status bar with enhanced date/time, network details, volume control
- **Rofi** - Beautiful KooL-style application launcher with 2-column layout
- **Wlogout** - Elegant power menu matching KooL's aesthetic
- **Foot Terminal** - Lightning-fast terminal with Fish shell pre-configured
- **Which-Key** - Interactive keybinding discovery system with category organization
- **VM Auto-scaling** - Automatic detection and optimization for all major VM platforms

**🎨 KooL Styling Throughout:**
- **Catppuccin Mocha** - Consistent color scheme across all components
- **Professional Layout** - Clean, organized interface inspired by JaKooLit's design
- **Beautiful Typography** - JetBrains Mono Nerd Font with proper icon support
- **Grouped Modules** - Waybar modules organized in professional groups

**⚡ VM Optimizations:**
- Auto-detects VMware, VirtualBox, UTM, Parallels, QEMU/KVM, and Hyper-V
- Resolution-aware scaling (1.25x for 1080p, 1.5x for 1440p, 1.75x for 4K+)
- Hardware cursor fixes and software rendering compatibility
- Memory-efficient window rules and layer configurations

**Workspace Organization:**
- Workspace 1: Terminals (foot)
- Workspace 2: Browsers (firefox) 
- Workspace 3: File managers (thunar)
- Workspace 4: Code editors

## 🎹 Essential Keybindings

| Key Combination | Action |
|---|---|
| `Super + Return` | Open terminal (current) |
| `Super + Shift + Return` | Choose terminal (foot/kitty/alacritty/etc) |
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
| `Super + /` | Show keybinding help (Which-Key) |

## 🧩 Included Components

### Waybar Status Bar
- **Location**: Top of screen with rounded corners
- **Left**: OS logo (app launcher), workspaces, window title, which-key helper
- **Center**: Time display and date with enhanced tooltips
- **Right**: System tray, network with SSID/details, volume control, battery, power menu
- **Styling**: Catppuccin Mocha theme with VM optimizations

**Waybar Interactions:**
- Click OS logo → Launch rofi
- Click which-key button (󰌌) → Show keybinding help
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

### Which-Key Helper
- **Style**: Interactive Rofi-based interface with Catppuccin colors
- **Categories**: Applications, Window Management, Workspaces, Tiling, System, Media, Screenshots
- **Features**: Organized keybinding discovery, tooltips, quick access

**Which-Key Usage:**
- `Super + /` → Show main keybinding categories
- Click waybar which-key button (󰌌) → Same as above
- Navigate categories to see detailed keybinding explanations
- Each category shows relevant shortcuts with descriptions
- Interactive help system for learning Hyprland efficiently

**Categories Available:**
- **📱 Applications** - Terminal, browser, file manager, launcher
- **🪟 Window Management** - Move, resize, close, floating, fullscreen
- **📊 Workspaces** - Switch, move windows, special workspaces
- **🔧 Tiling Controls** - Split direction, swap, master layout
- **⚙️ System** - Lock, logout, power menu, reload config
- **🎵 Media & Volume** - Volume, brightness, media keys
- **📸 Screenshots** - Full screen, area selection, clipboard
- **✨ Special** - VM features, customization, help

### VM Auto-Scaling
- **Detection**: Automatically identifies VM type on startup
- **Supported VMs**: VMware, VirtualBox, UTM, Parallels, QEMU/KVM
- **Scaling**: Resolution-aware scaling (1.25x for 1080p, 1.5x for 1440p, 1.75x for 4K+)
- **Optimizations**: VM-specific environment variables and cursor fixes

**Manual Rescaling:**
```bash
# Regenerate VM configuration
~/.config/hyprland/scripts/vm-scale.sh
# Then reload: Super + Shift + R
```

### Shell Configuration
**Default Shell:** The configuration uses **Fish shell by default** in the Foot terminal for enhanced user experience. To change your system default shell:

**Manual Shell Change:**
```bash
# Check available shells
cat /etc/shells

# Change to zsh (if installed)
chsh -s /bin/zsh

# Change to fish (if installed)  
chsh -s /bin/fish

# Change back to bash
chsh -s /bin/bash

# Note: Log out and back in for changes to take effect
```

**Or use the installer's shell chooser:**
```bash
# From the main Arch-Hyprland directory
./install-scripts/shell-chooser.sh
```

## 📝 Customization Guide

### Quick Edits

The main configuration file is located at: `~/.config/hypr/hyprland.conf`

**Directory Structure (uses correct conventions):**
- **Hyprland**: `~/.config/hypr/` (not hyprland)  
- **Waybar**: `~/.config/waybar/`
- **Rofi**: `~/.config/rofi/`
- **Foot**: `~/.config/foot/`
- **Wlogout**: `~/.config/wlogout/`

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

When installed, the KooL-optimized config creates this structure:

```
~/.config/hypr/               # Hyprland configuration (correct directory)
├── hyprland.conf            # Main KooL-optimized configuration
├── vm-monitor.conf          # Auto-generated VM scaling config  
└── scripts/
    ├── vm-scale.sh          # VM detection and scaling script
    ├── hyprland-which-key.sh # Interactive keybinding helper
    ├── terminal-chooser.sh   # Terminal selection script
    └── workspace-name.sh     # Workspace navigation helper

~/.config/waybar/            # Waybar status bar (correct directory)
├── config.jsonc            # Enhanced Waybar with KooL styling
└── style.css               # Professional Catppuccin Mocha theme

~/.config/rofi/              # Rofi launcher (correct directory)  
├── config-kool.rasi        # KooL-style Rofi configuration
├── kool-style.rasi         # Beautiful 2-column theme
└── fonts.rasi              # Font settings

~/.config/wlogout/           # Power menu (correct directory)
├── layout                  # Button layout and actions
└── style.css               # KooL-style Catppuccin theme

~/.config/foot/              # Terminal configuration
└── foot.ini                # Optimized Foot with Fish shell

~/.config/swww/              # Wallpaper daemon
└── wall.png                # Default solid color wallpaper
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

To reset or reinstall the KooL-optimized config:

```bash
# From main Arch-Hyprland directory
./install-scripts/simple-config.sh

# This script will:
# - Backup existing configurations
# - Install fresh KooL-optimized configs
# - Update all directory paths to correct conventions
# - Apply VM optimizations
```

This will overwrite your current configurations with the default KooL-optimized setup.

## 🎯 Philosophy

This configuration combines **JaKooLit's beautiful KooL aesthetic** with **performance-first VM optimization**. It embraces Hyprland's dynamic tiling strength while providing a complete, professional desktop environment that performs excellently in virtual machines.

The KooL-optimized approach:
- **Beauty without compromise** - Stunning visuals optimized for performance
- **Professional workflow** - Complete desktop stack for productivity  
- **VM-first design** - Every component optimized for virtual machine efficiency
- **Fish shell integration** - Modern, user-friendly terminal experience

**Happy tiling with KooL style! 🪟💫**