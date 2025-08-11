# Optional Scripts for Non-VM Setups

These scripts have been moved from the main installation because they're not needed for VMware Fusion on Apple Silicon Macs. Use these scripts if you're running on bare metal hardware or need specific hardware configurations.

## 🖥️ Hardware-Specific Scripts

### NVIDIA GPU Support
- **`nvidia.sh`** - NVIDIA GPU driver installation (nvidia-dkms, nvidia-utils, nvidia-settings)
- **`nvidia_nouveau.sh`** - Blacklists nouveau driver for NVIDIA setups

**When to use:** Only on systems with physical NVIDIA GPUs. Not needed in VMware Fusion.

### ROG Laptop Support  
- **`rog.sh`** - ASUS ROG laptop specific packages (asusctl, supergfxctl, rog-control-center)

**When to use:** Only on ASUS ROG laptops with specific hardware features.

## 🚀 How to Use These Scripts

### Option 1: Manual Installation
Run scripts individually from the main Arch-Hyprland directory:

```bash
cd ~/Arch-Hyprland

# For NVIDIA GPU support
./optional-scripts/nvidia.sh

# For ROG laptop features  
./optional-scripts/rog.sh

# To blacklist nouveau (usually run after nvidia.sh)
./optional-scripts/nvidia_nouveau.sh
```

### Option 2: Modify install.sh (Advanced)
If you need these regularly, you can temporarily move them back to `install-scripts/` and uncomment the relevant sections in `install.sh`:

```bash
# Move back temporarily
mv optional-scripts/nvidia.sh install-scripts/
mv optional-scripts/rog.sh install-scripts/

# Edit install.sh to uncomment the nvidia/rog sections
# Then run: ./install.sh --nvidia --rog
```

## ⚠️ Important Notes

- **VMware Users**: These scripts are not needed and may cause issues in virtual machines
- **Prerequisites**: Ensure you have the base system installed first
- **Dependencies**: Some scripts may require packages from the main installation
- **Logs**: Scripts will create logs in the main `Install-Logs/` directory

## 🔄 Why These Were Moved

This fork focuses on **VMware Fusion optimization** for Apple Silicon Macs. These hardware-specific components:

- Add unnecessary complexity for VM users
- May conflict with VM graphics drivers  
- Require physical hardware that VMs don't have
- Increase installation time and potential failure points

For the cleanest VM experience, stick to the main installation without these optional components.

---
*Part of the VMware Fusion optimized Arch-Hyprland installer*