# 🔧 Optional Scripts

This directory contains optional scripts for specific hardware configurations and use cases that aren't part of the main installer flow.

## 📁 Available Scripts

### VMware/Virtualization
- **`openvm-tools.sh`** - VMware Tools for better VM integration

### Hardware-Specific
- **`nvidia.sh`** - NVIDIA GPU drivers and configuration
- **`rog.sh`** - ASUS ROG laptop specific optimizations

### Performance & Features  
- **`python-pytorch.sh`** - PyTorch ML/AI development setup
- **`asus_2_in_1.sh`** - ASUS 2-in-1 touchscreen laptop support

## 🚀 Usage

```bash
cd ~/Arch-Hyprland/optional-scripts

# Make executable and run (most scripts are already executable)
./<script-name>.sh

# Examples:
./openvm-tools.sh     # Install VMware tools
./nvidia.sh           # Install NVIDIA drivers  
./rog.sh             # ROG laptop optimizations
```

## 🎯 When to Use

These scripts are **optional** and should only be used if:

1. **Environment Match**: You have the specific setup (VMware, NVIDIA, ROG, etc.)
2. **Specific Needs**: You need the particular functionality
3. **Post-Installation**: Run these AFTER completing the main installation

## 📋 Script Details

### 🖥️ `openvm-tools.sh` - VMware Tools
**For VMware virtual machines (especially VMware Fusion on Apple Silicon)**
- Builds and installs open-vm-tools from source for optimal compatibility
- Enables full VMware integration with host system
- Supports modern VMware Fusion versions on Apple Silicon Macs
- **Essential for VMware Fusion VMs on M1/M2/M3 Macs**

**Usage:**
```bash
./openvm-tools.sh
```

**What it does:**
1. **Installs build dependencies**: All required packages for compilation
2. **Downloads VMware tools source**: From optimized repository for Arch Linux
3. **Builds tools from source**: Ensures compatibility with latest kernel
4. **Configures services**: Automatically starts VMware integration services
5. **Optional reboot**: Prompts user to reboot for complete activation

**Features enabled:**
- 📋 **Clipboard sharing**: Seamless copy/paste between macOS host and Linux VM
- 🖱️ **Drag & drop files**: Direct file transfer between host and guest
- 📺 **Dynamic resolution**: Auto-adjusts to VMware Fusion window size
- ⏰ **Time synchronization**: Keeps VM time in sync with host
- 🔧 **VM hardware integration**: Enhanced mouse, keyboard, and display handling

**🍎 macOS + VMware Fusion specific setup:**
- **Host clipboard integration**: Copy on macOS (Cmd+C) → Paste in VM (Ctrl+V)
- **Seamless window integration**: VM adapts to Fusion window resizing
- **Shared folders**: Access macOS folders from within the VM
- **Performance optimization**: Tuned for Apple Silicon virtualization

**Post-installation:**
- Reboot required for full functionality
- Check status: `systemctl status vmtoolsd`
- Test clipboard: Copy text between host and VM

### 🎮 `nvidia.sh` - NVIDIA Drivers
**For bare metal with NVIDIA GPUs**
- Installs NVIDIA proprietary drivers
- Configures Hyprland for NVIDIA
- Sets up CUDA support
- **⚠️ Do NOT use in VMs**

### 🔥 `rog.sh` - ROG Optimizations
**For ASUS ROG laptops**
- Gaming performance tuning
- RGB lighting control
- Power management
- **ROG laptops only**

### 🧠 `python-pytorch.sh` - ML Development
**For AI/ML development**
- PyTorch and ML libraries
- Jupyter notebook setup
- CUDA support (requires NVIDIA)

### 📱 `asus_2_in_1.sh` - Touchscreen Support
**For ASUS 2-in-1 laptops**
- Touchscreen calibration
- 2-in-1 input handling

## ⚠️ Important Notes

- **Environment-Specific**: Only use scripts that match your setup
- **VM vs Bare Metal**: VMware scripts for VMs, hardware scripts for bare metal
- **Test First**: Scripts modify system configuration
- **One at a Time**: Run scripts individually, not all at once

## 🔄 Migration from Main Installer

These scripts were moved from the main installer to:
- **Simplify VM installations**: Remove hardware-specific complexity
- **Prevent conflicts**: Avoid VM graphics driver issues
- **Focused approach**: Main installer targets VMware Fusion optimization
- **Better organization**: Clear separation of optional vs required components

---
*Part of the VMware Fusion optimized Arch-Hyprland installer*