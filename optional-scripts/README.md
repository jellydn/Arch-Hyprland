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
**For VMware virtual machines**
- Installs open-vm-tools for VMware integration
- Enables clipboard sharing and drag & drop
- Provides dynamic screen resolution
- Sets up shared folders at `/mnt/hgfs/`
- **Recommended for all VMware VMs**

**Usage:**
```bash
./openvm-tools.sh
```

**Features enabled:**
- 📋 Clipboard sharing (copy/paste)
- 🖱️ Drag & drop files
- 📺 Dynamic resolution
- ⏰ Time sync
- 📁 Shared folders

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