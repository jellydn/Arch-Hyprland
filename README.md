# 🚀 Arch-Hyprland for VMware Fusion (Apple Silicon)

A streamlined Arch Linux + Hyprland installer optimized for VMware Fusion on Apple Silicon Macs (M1/M2/M3).

## ✨ What's Different in This Fork

- **🖥️ VMware Fusion Optimized**: Specifically tuned for Apple Silicon Mac virtualization
- **⚡ Simplified Defaults**: Foot terminal + Firefox browser as sensible defaults  
- **🐚 Shell Choice**: Both Zsh and Fish available - choose your preference after install
- **🎯 VM-Friendly**: Lightweight configuration perfect for virtual machines
- **🔧 Simple Config**: Alternative to full KooL dotfiles for easier customization
- **🗂️ Hardware-Specific Cleanup**: NVIDIA/ROG scripts moved to `optional-scripts/` for cleaner VM installs

## 🎯 Quick Start (One Command)

**For VMware Fusion on Apple Silicon Macs:**

```bash
git clone --depth=1 https://github.com/jellydn/Arch-Hyprland.git ~/Arch-Hyprland
cd ~/Arch-Hyprland
chmod +x install.sh

# 🚀 Recommended setup for VMware Fusion
./install.sh --auto --vm --dots --fish --foot --firefox --gtk-themes --bluetooth --thunar
```

**What this includes:**
- ✅ VM optimizations for VMware Fusion
- ✅ Foot terminal (lightweight, VM-friendly)
- ✅ Firefox browser (Wayland-native)
- ✅ Fish shell (user-friendly)
- ✅ Simple Hyprland configuration (tiling-focused)
- ✅ GTK themes and Bluetooth support
- ✅ File manager and essential utilities

## 🖥️ VMware Fusion Setup Tips

### Before Installation
1. **Enable 3D Acceleration** in VM settings
2. **Allocate sufficient resources**: 4GB+ RAM, 2+ CPU cores
3. **Install VMware Tools** after Arch base installation

### VM Settings Recommendations
- **Memory**: 4-8GB RAM
- **Processors**: 2-4 cores
- **Graphics**: Enable 3D acceleration
- **Display**: Auto-detect resolution

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

### Simple Configuration (Recommended)
The installer includes a simplified Hyprland config that:
- Embraces tiling window management
- Uses Foot terminal and Firefox
- VM-optimized performance settings
- Catppuccin color scheme

### Customization
After installation, configs are located in:
- **Hyprland**: `~/.config/hypr/`
- **Foot**: `~/.config/foot/`
- **Shell configs**: `~/.zshrc` or `~/.config/fish/`

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