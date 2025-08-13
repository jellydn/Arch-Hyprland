# 🚀 Arch-Hyprland for VMware Fusion (Apple Silicon)

A streamlined Arch Linux + Hyprland installer optimized for VMware Fusion on Apple Silicon Macs (M1/M2/M3).

## ✨ What's Different in This Fork

- **🖥️ VMware Fusion Optimized**: Specifically tuned for Apple Silicon Mac virtualization
- **⚡ Simplified Defaults**: Foot terminal + Firefox browser as sensible defaults  
- **🐚 Shell Choice**: Both Zsh and Fish available - choose your preference after install
- **🎯 VM-Friendly**: Lightweight configuration perfect for virtual machines
- **🔧 Simple Config**: Alternative to full KooL dotfiles for easier customization
- **🗂️ Hardware-Specific Cleanup**: NVIDIA/ROG/VM scripts moved to `optional-scripts/` for cleaner installs

## 🎯 Quick Start (One Command)

**For VMware Fusion on Apple Silicon Macs:**

```bash
git clone --depth=1 https://github.com/jellydn/Arch-Hyprland.git ~/Arch-Hyprland
cd ~/Arch-Hyprland
chmod +x install.sh

# 🚀 Recommended setup for VMware Fusion
./install.sh --auto --dots --fish --foot --firefox --gtk-themes --bluetooth --thunar
```

**What this includes:**
- ✅ Hyprland tiling window manager
- ✅ Foot terminal (lightweight, VM-friendly)
- ✅ Firefox browser (Wayland-native)
- ✅ Fish shell (user-friendly)
- ✅ Simple Hyprland configuration with VM optimizations
- ✅ GTK themes and Bluetooth support
- ✅ File manager and essential utilities

**After installation, add VMware tools:**
```bash
# Install VMware tools for better integration
./optional-scripts/openvm-tools.sh
```

## 🖥️ VMware Fusion Setup Guide

### 1. VM Settings (Before Installation)
- **Memory**: 8GB+ RAM recommended
- **Processors**: 2-4 cores
- **Graphics**: Enable 3D acceleration
- **Display**: Auto-detect resolution
- **Sharing**: Enable clipboard and drag & drop

### 2. Arch Installation
Run the installer as shown in Quick Start above.

### 3. VMware Tools (Post-Installation)
```bash
# Install VMware tools for full integration
cd ~/Arch-Hyprland
./optional-scripts/openvm-tools.sh
```

**VMware Tools Features:**
- 📋 Clipboard sharing (copy/paste between host and VM)
- 🖱️ Drag & drop files
- 📺 Dynamic screen resolution
- ⏰ Time synchronization
- 📁 Shared folders at `/mnt/hgfs/`

**🍎 macOS + VMware Fusion Clipboard Setup:**
1. In VMware Fusion: **VM → Settings → Isolation**
2. Enable: ✅ **Enable Shared Clipboard**
3. Enable: ✅ **Enable Drag and Drop**
4. **Reboot the VM** after enabling these settings
5. Test copying: macOS text → Paste in Linux VM (Ctrl+V)
6. Test copying: Linux VM text → Paste on macOS (Cmd+V)

**🔧 Clipboard Troubleshooting:**
```bash
# Check VMware Tools status
systemctl status vmtoolsd

# Manual clipboard commands in Linux VM
echo 'test text' | wl-copy    # Copy to clipboard
wl-paste                      # Paste from clipboard

# Restart VMware Tools if needed
sudo systemctl restart vmtoolsd
```

## 🐚 Choose Your Shell

After installation, both Zsh and Fish are available:

```bash
# Interactive shell chooser
./install-scripts/shell-chooser.sh
```

**Shell Options:**
- **Fish**: Smart autocompletion, user-friendly syntax
- **Zsh**: Oh-My-Zsh with plugins and themes

## 🎨 Configuration Options

### Simple KooL Configuration (Recommended)
The installer includes a **KooL-optimized Hyprland config** that provides:
- **🏢 Professional desktop environment** based on JaKooLit's dotfiles structure
- **⚡ VM performance optimization**: No animations, minimal blur, optimized for VMware/VirtualBox
- **🎨 Beautiful KooL styling**: Catppuccin Mocha colors with professional layout
- **🦶 Foot terminal**: Fast, lightweight, VM-optimized with Fish shell
- **🔧 Complete desktop stack**: Waybar, Rofi, Wlogout, Which-Key helper

### 🚀 Key Features

#### **Desktop Components**
- **📊 Waybar**: Professional status bar with enhanced date/time, network details, volume control
- **🚀 Rofi**: Beautiful application launcher with search and file browsing
- **🚪 Wlogout**: Elegant power menu (lock, logout, shutdown, reboot, suspend)
- **󰌌 Which-Key Helper**: Interactive keybinding discovery system (`Super + /`)
- **🔧 VM Auto-scaling**: Automatic detection and optimization for VMware, VirtualBox, UTM, Parallels

#### **Performance Optimizations**
- **🚫 NO ANIMATIONS**: Maximum VM performance
- **⚡ Minimal effects**: Optimized blur and shadows for virtual machines
- **🎯 Efficient tiling**: KooL's advanced window management without performance cost
- **📱 Fish shell**: User-friendly terminal with smart completions

### 📋 Essential Keybindings

#### **🖥️ Applications**
- `Super + Return` - Open terminal (Foot with Fish shell)
- `Super + Shift + Return` - Terminal chooser (foot/kitty/alacritty/etc)
- `Super + B` - Open browser (Firefox)
- `Super + D` - Application launcher (Rofi)
- `Super + R` - Run command (Rofi)
- `Super + E` - File manager (Thunar)
- `Super + /` - Show keybinding help (Which-Key)

#### **🪟 Window Management**
- `Super + Q` - Close window
- `Super + V` - Toggle floating/tiled
- `Super + F` - Fullscreen
- `Super + J` - Toggle split direction
- `Super + Arrows` - Move focus
- `Super + Shift + Arrows` - Move window
- `Super + Ctrl + Arrows` - Resize window

#### **📊 Workspaces**
- `Super + 1-9` - Switch to workspace
- `Super + Shift + 1-9` - Move window to workspace
- `Super + S` - Toggle special workspace
- `Super + Mouse Scroll` - Switch workspaces

#### **⚙️ System Controls**
- `Super + L` - Lock screen
- `Super + Shift + Q` - Logout menu (Wlogout)
- `Super + Shift + R` - Reload Hyprland configuration
- `Super + Shift + W` - Restart Waybar
- `Alt + Tab` - Window switcher

#### **🎵 Media & Volume**
- `Volume Up/Down` - Adjust volume
- `Volume Mute` - Toggle audio mute
- `Brightness Up/Down` - Screen brightness
- `Print Screen` - Full screenshot
- `Super + Shift + S` - Area screenshot

### 🖱️ Desktop Interactions
- **Click Waybar OS logo** → Launch Rofi
- **Click Waybar which-key button (󰌌)** → Show keybinding help
- **Click Waybar volume** → Open pavucontrol
- **Click Waybar power** → Open logout menu
- **VM auto-scaling** → Detects and optimizes display automatically

### 📁 Configuration Files
After installation, configs are located in:
- **Hyprland**: `~/.config/hypr/` (uses correct directory convention)
- **Waybar**: `~/.config/waybar/` 
- **Rofi**: `~/.config/rofi/`
- **Foot**: `~/.config/foot/`
- **Wlogout**: `~/.config/wlogout/`
- **Shell configs**: `~/.zshrc` or `~/.config/fish/`

### 🔧 Customization Guide

**Quick customizations** in `~/.config/hypr/hyprland.conf`:
```bash
# Change terminal
$term = foot  # Change to kitty, alacritty, etc.

# Change browser  
$browser = firefox  # Change to brave, chromium, etc.

# Adjust gaps
gaps_in = 2    # Inner gaps between windows
gaps_out = 4   # Outer gaps from screen edges

# Change colors (Catppuccin Mocha)
col.active_border = rgba(cba6f7ff) rgba(f5c2e7ff) 45deg
col.inactive_border = rgba(6c7086ff)
```

**Apply changes**: `Super + Shift + R` or restart Hyprland

### 🌐 Resources
- **Hyprland Wiki**: https://wiki.hyprland.org/
- **KooL Dotfiles**: https://github.com/JaKooLit/Hyprland-Dots  
- **Re-run config**: `./install-scripts/simple-config.sh`

## 📋 Manual Installation

```bash
git clone --depth=1 https://github.com/jellydn/Arch-Hyprland.git ~/Arch-Hyprland
cd ~/Arch-Hyprland
chmod +x install.sh
./install.sh
```

Then select options through the interactive menu.

## 🔧 Available Options

```bash
./install.sh --help
```

**Key flags:**
- `--vm`: VMware/VirtualBox optimizations
- `--auto`: Skip confirmation prompts
- `--dots`: Install pre-configured dotfiles
- `--foot`: Foot terminal (default)
- `--firefox`: Firefox browser (default)
- `--fish`: Fish shell
- `--zsh`: Zsh shell

**Hardware-specific options** (moved to [`optional-scripts/`](optional-scripts/)):
- NVIDIA/ROG options moved for cleaner VM installations
- Use these only for bare metal installations with specific hardware

## 🆘 Troubleshooting

**Common VMware Fusion Issues:**
- If display issues occur, ensure 3D acceleration is enabled
- For performance issues, allocate more RAM/CPU cores
- If mouse/keyboard lag, install `open-vm-tools`

**Shell Selection:**
- Both shells can be installed simultaneously
- Use `shell-chooser.sh` to switch between them
- **Manual change**: `chsh -s /bin/zsh` or `chsh -s /bin/fish` (logout/login required)
- No automatic shell changes - your choice!

## 🔗 Links

- **Original Repository**: [JaKooLit/Arch-Hyprland](https://github.com/JaKooLit/Arch-Hyprland)
- **Hyprland Documentation**: [hyprland.org](https://hyprland.org/)
- **VMware Fusion**: [vmware.com/products/fusion](https://www.vmware.com/products/fusion.html)

## ⚠️ Requirements

- Minimal Arch Linux installation
- VMware Fusion on Apple Silicon Mac
- Internet connection for package downloads
- `base-devel` group installed

## 🙏 Credits

Based on [KooL's Arch-Hyprland installer](https://github.com/JaKooLit/Arch-Hyprland) with optimizations for Apple Silicon virtualization.

---
*Optimized for VMware Fusion • Apple Silicon Ready • VM-Friendly*