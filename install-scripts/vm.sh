#!/bin/bash
# 💫 https://github.com/jellydn/Arch-Hyprland 💫 #
# VM optimizations and packages for virtual machines #

vm_pkg=(
  open-vm-tools
  xf86-video-vmware
  xf86-input-vmmouse
  mesa
)

# VM-specific packages for different hypervisors
vm_pkg_optional=(
  spice-vdagent    # For QEMU/KVM with SPICE
  virtualbox-guest-utils  # For VirtualBox (if detected)
)

## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change the working directory to the parent directory of the script
PARENT_DIR="$SCRIPT_DIR/.."
cd "$PARENT_DIR" || { echo "${ERROR} Failed to change directory to $PARENT_DIR"; exit 1; }

# Source the global functions script
if ! source "$(dirname "$(readlink -f "$0")")/Global_functions.sh"; then
  echo "Failed to source Global_functions.sh"
  exit 1
fi

# Set the name of the log file to include the current date and time
LOG="Install-Logs/install-$(date +%d-%H%M%S)_vm.log"

# Function to detect VM type
detect_vm_type() {
    local vm_type="unknown"
    local arch=$(uname -m)
    
    # Check for VMware (including Fusion, Workstation, ESXi)
    if lspci | grep -i vmware >/dev/null 2>&1; then
        vm_type="vmware"
    elif dmidecode -s system-manufacturer 2>/dev/null | grep -i "vmware" >/dev/null 2>&1; then
        vm_type="vmware"
    elif dmesg 2>/dev/null | grep -i "vmware\|vmxnet\|pvscsi" | head -1 >/dev/null 2>&1; then
        vm_type="vmware"
    
    # Check for UTM (common on macOS, especially Apple Silicon)
    elif dmidecode -s system-product-name 2>/dev/null | grep -i "utm\|apple virtualization" >/dev/null 2>&1; then
        vm_type="utm"
    elif lspci | grep -i "apple\|utm" >/dev/null 2>&1; then
        vm_type="utm"
    elif [[ "$arch" == "aarch64" ]] && (dmesg 2>/dev/null | grep -i "virtio\|qemu" >/dev/null 2>&1); then
        # Likely UTM on Apple Silicon
        vm_type="utm"
    
    # Check for VirtualBox
    elif lspci | grep -i virtualbox >/dev/null 2>&1 || lsmod | grep -i vboxguest >/dev/null 2>&1; then
        vm_type="virtualbox"
    elif dmidecode -s system-product-name 2>/dev/null | grep -i "virtualbox" >/dev/null 2>&1; then
        vm_type="virtualbox"
    
    # Check for Parallels (common on macOS)
    elif lspci | grep -i parallels >/dev/null 2>&1; then
        vm_type="parallels"
    elif dmidecode -s system-manufacturer 2>/dev/null | grep -i "parallels" >/dev/null 2>&1; then
        vm_type="parallels"
    
    # Check for QEMU/KVM (including UTM backend)
    elif lscpu | grep -i "hypervisor vendor" | grep -i "kvm" >/dev/null 2>&1; then
        vm_type="qemu_kvm"
    elif lspci | grep -i "red hat\|virtio" >/dev/null 2>&1; then
        vm_type="qemu_kvm"
    elif dmesg 2>/dev/null | grep -i "kvm\|qemu" >/dev/null 2>&1; then
        vm_type="qemu_kvm"
    
    # Check for Microsoft Hyper-V
    elif lscpu | grep -i "microsoft" >/dev/null 2>&1; then
        vm_type="hyperv"
    elif dmidecode -s system-manufacturer 2>/dev/null | grep -i "microsoft" >/dev/null 2>&1; then
        vm_type="hyperv"
    
    # Check for Xen
    elif lscpu | grep -i "xen" >/dev/null 2>&1; then
        vm_type="xen"
    elif dmesg 2>/dev/null | grep -i "xen" >/dev/null 2>&1; then
        vm_type="xen"
    
    # Check DMI info for generic VM indicators
    elif dmidecode -s system-product-name 2>/dev/null | grep -i "virtual\|vmware\|qemu\|kvm\|xen\|bochs" >/dev/null 2>&1; then
        vm_type="generic_vm"
    
    # Check for containerized environment
    elif [[ -f /.dockerenv ]] || grep -q docker /proc/1/cgroup 2>/dev/null; then
        vm_type="container"
    fi
    
    echo "$vm_type"
}

# Installing VM packages
printf "\n%s - Installing ${SKY_BLUE}VM optimization packages${RESET} .... \n" "${NOTE}"

# Detect VM type
VM_TYPE=$(detect_vm_type)
echo "${INFO} Detected VM environment: ${VM_TYPE}" | tee -a "$LOG"

# Install common VM packages
for VM_PKG in "${vm_pkg[@]}"; do
  install_package "$VM_PKG" "$LOG"
done 

# Install VM-specific packages based on detected type
case "$VM_TYPE" in
    "vmware")
        echo "${INFO} Installing VMware-specific optimizations (Fusion/Workstation/ESXi)..." | tee -a "$LOG"
        # VMware tools are already included in open-vm-tools
        # Additional VMware-specific optimizations
        echo "WLR_NO_HARDWARE_CURSORS=1" >> /tmp/vm_env_vars 2>/dev/null || true
        ;;
    "utm")
        echo "${INFO} Installing UTM-specific optimizations (Apple Silicon/Intel)..." | tee -a "$LOG"
        install_package "spice-vdagent" "$LOG"
        # UTM uses QEMU backend, so similar optimizations apply
        # Special optimizations for Apple Silicon
        local arch=$(uname -m)
        if [[ "$arch" == "aarch64" ]] || [[ "$arch" == "arm64" ]]; then
            echo "${INFO} Applying ARM64/Apple Silicon optimizations..." | tee -a "$LOG"
            echo "WLR_RENDERER_ALLOW_SOFTWARE=1" >> /tmp/vm_env_vars 2>/dev/null || true
        fi
        ;;
    "virtualbox")
        echo "${INFO} Installing VirtualBox-specific optimizations..." | tee -a "$LOG"
        install_package "virtualbox-guest-utils" "$LOG"
        ;;
    "parallels")
        echo "${INFO} Installing Parallels-specific optimizations (macOS)..." | tee -a "$LOG"
        # Parallels Tools are usually pre-installed on modern versions
        # Apply similar optimizations to VMware
        echo "WLR_NO_HARDWARE_CURSORS=1" >> /tmp/vm_env_vars 2>/dev/null || true
        ;;
    "qemu_kvm")
        echo "${INFO} Installing QEMU/KVM-specific optimizations..." | tee -a "$LOG"
        install_package "spice-vdagent" "$LOG"
        ;;
    "hyperv")
        echo "${INFO} Installing Hyper-V-specific optimizations..." | tee -a "$LOG"
        # Hyper-V integration services
        install_package "hyperv" "$LOG" 2>/dev/null || echo "${WARN} Hyper-V packages not available in AUR" | tee -a "$LOG"
        ;;
    "xen")
        echo "${INFO} Installing Xen-specific optimizations..." | tee -a "$LOG"
        install_package "xen" "$LOG" 2>/dev/null || echo "${WARN} Xen packages not available" | tee -a "$LOG"
        ;;
    "container")
        echo "${INFO} Container environment detected - applying minimal optimizations..." | tee -a "$LOG"
        # Skip graphics packages for containers
        echo "WLR_RENDERER_ALLOW_SOFTWARE=1" >> /tmp/vm_env_vars 2>/dev/null || true
        ;;
    *)
        echo "${INFO} Generic/unknown VM detected, applying common optimizations..." | tee -a "$LOG"
        echo "WLR_NO_HARDWARE_CURSORS=1" >> /tmp/vm_env_vars 2>/dev/null || true
        ;;
esac

# VM-specific Hyprland optimizations
echo "${INFO} Applying VM-specific Hyprland configurations..." | tee -a "$LOG"

# Create VM-specific Hyprland config directory
mkdir -p "$HOME/.config/hypr/vm-configs"

# Create VM optimizations config file
cat > "$HOME/.config/hypr/vm-configs/vm-optimizations.conf" << 'EOF'
# VM-specific Hyprland optimizations
# Generated by KooL Arch-Hyprland installer

# Reduce animations for better VM performance
animations {
    enabled = true
    bezier = myBezier, 0.05, 0.9, 0.1, 1.05
    animation = windows, 1, 2, myBezier
    animation = windowsOut, 1, 2, default, popin 80%
    animation = border, 1, 5, default
    animation = borderangle, 1, 4, default
    animation = fade, 1, 2, default
    animation = workspaces, 1, 2, default
}

# VM-optimized rendering settings
render {
    explicit_sync = 0
    explicit_sync_kms = 0
}

# Reduce resource usage
decoration {
    blur {
        enabled = false  # Disable blur for better VM performance
    }
    drop_shadow = false  # Disable shadows for better performance
}

# VM-specific environment variables (base set)
env = WLR_NO_HARDWARE_CURSORS,1
env = WLR_RENDERER_ALLOW_SOFTWARE,1
EOF

# Add additional environment variables from VM detection
if [[ -f /tmp/vm_env_vars ]]; then
    while IFS= read -r env_var; do
        if [[ -n "$env_var" ]]; then
            echo "env = ${env_var}" >> "$HOME/.config/hypr/vm-configs/vm-optimizations.conf"
        fi
    done < /tmp/vm_env_vars
    rm -f /tmp/vm_env_vars
fi

# Add VM-specific display and architecture optimizations
cat >> "$HOME/.config/hypr/vm-configs/vm-optimizations.conf" << EOF

# VM display settings - adjust based on common VM screen sizes
monitor = Virtual-1, preferred, 0x0, 1
monitor = ,preferred,auto,1

# Architecture-specific optimizations
EOF

# Add architecture-specific optimizations
local arch=$(uname -m)
case "$arch" in
    "aarch64"|"arm64")
        cat >> "$HOME/.config/hypr/vm-configs/vm-optimizations.conf" << 'EOF'

# ARM64/Apple Silicon specific optimizations
env = WLR_RENDERER,pixman
render {
    explicit_sync = 0
}
decoration {
    blur {
        enabled = false
        passes = 1
    }
}
EOF
        ;;
    "x86_64")
        cat >> "$HOME/.config/hypr/vm-configs/vm-optimizations.conf" << 'EOF'

# x86_64 specific optimizations  
render {
    explicit_sync = 0
    explicit_sync_kms = 0
}
EOF
        ;;
esac

# Add VM-specific optimizations based on detected type
cat >> "$HOME/.config/hypr/vm-configs/vm-optimizations.conf" << EOF

# ${VM_TYPE} specific optimizations
EOF

case "$VM_TYPE" in
    "utm"|"parallels")
        cat >> "$HOME/.config/hypr/vm-configs/vm-optimizations.conf" << 'EOF'
# UTM/Parallels optimizations
windowrulev2 = noblur,class:.*
windowrulev2 = noshadow,class:.*
env = LIBGL_ALWAYS_SOFTWARE,1
EOF
        ;;
    "vmware")
        cat >> "$HOME/.config/hypr/vm-configs/vm-optimizations.conf" << 'EOF'  
# VMware optimizations
misc {
    vfr = false  # Disable variable refresh rate
    vrr = 0
}
EOF
        ;;
    "virtualbox")
        cat >> "$HOME/.config/hypr/vm-configs/vm-optimizations.conf" << 'EOF'
# VirtualBox optimizations
misc {
    disable_hyprland_logo = true
    disable_splash_rendering = true
}
EOF
        ;;
esac

echo "${INFO} VM optimizations applied to ~/.config/hypr/vm-configs/vm-optimizations.conf" | tee -a "$LOG"

# Enable VM services
if systemctl list-unit-files | grep -q "vmtoolsd.service"; then
    echo "${INFO} Enabling VMware tools service..." | tee -a "$LOG"
    sudo systemctl enable vmtoolsd.service
fi

if systemctl list-unit-files | grep -q "vboxservice.service"; then
    echo "${INFO} Enabling VirtualBox guest service..." | tee -a "$LOG"
    sudo systemctl enable vboxservice.service
fi

# Additional VM optimizations
echo "${INFO} Applying additional VM optimizations..." | tee -a "$LOG"

# Disable some resource-intensive services for VM
services_to_mask=(
    "systemd-oomd.service"  # Out of memory daemon (can cause issues in VMs)
)

for service in "${services_to_mask[@]}"; do
    if systemctl list-unit-files | grep -q "$service"; then
        echo "${INFO} Masking $service for VM optimization..." | tee -a "$LOG"
        sudo systemctl mask "$service" 2>/dev/null || true
    fi
done

# Create comprehensive VM-specific tips file
cat > "$HOME/.config/hypr/vm-configs/VM-TIPS.md" << EOF
# VM-Specific Tips for KooL Hyprland
## Detected VM Environment: ${VM_TYPE}

## Performance Optimizations Applied:
- VM type auto-detection and specific optimizations
- Reduced animations for better performance
- Disabled blur effects and shadows  
- Optimized rendering settings for ${VM_TYPE}
- Architecture-specific optimizations ($(uname -m))
- VM-specific environment variables set

## Platform-Specific Settings:

### UTM (macOS - Apple Silicon/Intel):
- SPICE agent installed for better integration
- Software rendering enabled for compatibility
- ARM64 optimizations applied (if applicable)
- Recommended: Enable hardware acceleration in UTM settings
- Use VirtIO devices for better performance

### VMware (Fusion/Workstation/ESXi):
- VMware Tools installed via open-vm-tools
- Hardware cursor disabled for stability
- 3D acceleration recommended in VM settings
- Allocate sufficient video memory (128MB+)

### VirtualBox:
- Guest Additions installed automatically
- 3D acceleration should be enabled in settings
- Increase video memory allocation
- Enable VT-x/AMD-V in host BIOS

### Parallels Desktop (macOS):
- Parallels Tools usually pre-installed
- Hardware acceleration optimizations applied
- Coherence mode may affect performance

### QEMU/KVM:
- SPICE agent for clipboard and display integration
- VirtIO drivers for optimal performance
- Use QXL or VirtIO-GPU display adapter

## Manual Optimizations You Can Apply:

### 1. VM Settings (Host Side):
#### UTM:
- Enable hardware acceleration
- Use VirtIO network and storage
- Allocate 8GB+ RAM for smooth operation

#### VMware:
- Enable 3D acceleration
- Allocate sufficient RAM (8GB+ recommended)
- Enable VT-x/AMD-V virtualization
- Increase video memory to 128MB+

#### VirtualBox:
- Enable 3D acceleration in Display settings
- Allocate maximum video memory (256MB)
- Enable VT-x/AMD-V in host BIOS
- Use VBoxSVGA graphics controller

### 2. Additional Hyprland Tweaks:
Add these to your hyprland.conf if performance is still poor:
\`\`\`
decoration {
    blur {
        enabled = false
    }
    drop_shadow = false
    rounding = 0  # Disable rounded corners
}

animations {
    enabled = false  # Disable all animations
}

misc {
    disable_hyprland_logo = true
    disable_splash_rendering = true
    vfr = false  # Disable variable refresh rate
}
\`\`\`

### 3. Resolution and Display:
- UTM: Use common resolutions (1920x1080, 1366x768, 1440x900)
- VMware: Supports dynamic resolution changes
- VirtualBox: Install Guest Additions for proper scaling
- Avoid high refresh rates (60Hz is optimal)
- Single monitor setup recommended for best performance

### 4. Resource Management:
- Close unnecessary applications
- Limit number of workspaces to 4 or fewer
- Use lightweight applications when possible
- Disable compositor effects if needed

## Architecture-Specific Notes:

### ARM64/Apple Silicon:
- Software rendering may be required
- Pixman renderer used for compatibility
- Some applications may need Rosetta 2 translation

### x86_64:
- Hardware acceleration more readily available
- Better compatibility with Linux applications

## Troubleshooting by Platform:

### UTM:
- Black screen: Check hardware acceleration settings
- Poor performance: Switch to software rendering
- Mouse issues: Install SPICE guest tools

### VMware:
- Screen flickering: Disable 3D acceleration temporarily
- Resolution issues: Install/reinstall VMware Tools
- Input lag: Check mouse integration settings

### VirtualBox:
- Graphics glitches: Update Guest Additions
- Slow performance: Increase video memory allocation
- Clipboard issues: Reinstall Guest Additions

### General Issues:
- Black screen: Try WLR_NO_HARDWARE_CURSORS=1
- Rendering issues: Try WLR_RENDERER_ALLOW_SOFTWARE=1
- Input lag: Check VM mouse integration settings
- Poor performance: Disable blur and animations completely

## Performance Testing:
Run these commands to test Hyprland performance:
\`\`\`bash
# Check current renderer
echo \$WLR_RENDERER

# Test with software renderer
WLR_RENDERER=pixman Hyprland

# Check graphics driver info
glxinfo | grep renderer
\`\`\`

## Getting Help:
- VM-specific configs: ~/.config/hypr/vm-configs/
- Log files: ~/Install-Logs/
- Hyprland wiki: https://wiki.hyprland.org/
EOF

echo "${OK} VM optimization installation completed!" | tee -a "$LOG"
echo "${INFO} VM tips and optimizations saved to ~/.config/hypr/vm-configs/" | tee -a "$LOG"

printf "\n%.0s" {1..2}