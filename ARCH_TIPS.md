# Arch Linux Tips for New Users

This guide provides essential tips and commands for users new to Arch Linux, especially those installing Hyprland through this repository.

## System Time Synchronization

One of the first things you should do after installing Arch Linux is to synchronize your system time:

```bash
# Enable automatic time synchronization
sudo systemctl enable systemd-timesyncd

# Start the time synchronization service
sudo systemctl start systemd-timesyncd

# Check time synchronization status
timedatectl status
```

## Essential System Commands

### Package Management with Pacman

```bash
# Update system packages
sudo pacman -Syu

# Install packages
sudo pacman -S package_name

# Search for packages
pacman -Ss search_term

# Remove packages
sudo pacman -R package_name

# Remove packages with dependencies
sudo pacman -Rs package_name

# Clean package cache
sudo pacman -Sc
```

### System Services

```bash
# Check service status
sudo systemctl status service_name

# Start a service
sudo systemctl start service_name

# Enable service to start on boot
sudo systemctl enable service_name

# Restart a service
sudo systemctl restart service_name

# View system logs
journalctl -xe
```

## Network Configuration

### Check Network Status
```bash
# Check network interfaces
ip addr show

# Check network connectivity
ping archlinux.org

# Check DNS resolution
nslookup google.com
```

### WiFi Connection (if needed)
```bash
# Connect to WiFi using iwctl
iwctl

# Inside iwctl:
# device list
# station wlan0 scan
# station wlan0 get-networks
# station wlan0 connect "Network_Name"
```

## User Management

### Add User to Groups
```bash
# Add user to wheel group (for sudo access)
sudo usermod -aG wheel username

# Add user to other useful groups
sudo usermod -aG audio,video,storage,optical,lp,scanner username
```

## File System and Storage

### Check Disk Usage
```bash
# Check disk space
df -h

# Check directory sizes
du -sh /path/to/directory

# Find large files
find /home -type f -size +100M 2>/dev/null
```

### File Permissions
```bash
# Make file executable
chmod +x filename

# Change file ownership
sudo chown username:username filename

# Common permission patterns
chmod 755 directory/  # rwxr-xr-x
chmod 644 file.txt    # rw-r--r--
```

## Hyprland-Specific Tips

### After Installing Hyprland
```bash
# Check if Hyprland is installed correctly
which Hyprland

# View Hyprland logs
journalctl -u display-manager

# Check graphics drivers
lspci -k | grep -A 2 -i "VGA\|3D"
```

### Useful Shortcuts (Default Hyprland)
- `Super + Return` - Open terminal
- `Super + Q` - Close window
- `Super + E` - Open file manager
- `Super + R` - Open application launcher
- `Super + Numbers` - Switch workspaces
- `Super + V` - Toggle clipboard manager (if configured)

## Clipboard Management

### Installing Clipboard Manager
```bash
# Install wl-clipboard for Wayland
sudo pacman -S wl-clipboard

# Install clipman (clipboard manager for Hyprland)
sudo pacman -S clipman

# Or install cliphist (alternative clipboard manager)
paru -S cliphist-git  # or yay -S cliphist-git
```

### Copy and Paste Operations

#### Terminal Copy/Paste
```bash
# In most terminals:
# Copy: Ctrl + Shift + C
# Paste: Ctrl + Shift + V

# Command line clipboard operations with wl-clipboard:
# Copy from command output to clipboard
echo "Hello World" | wl-copy

# Copy file contents to clipboard
wl-copy < file.txt

# Paste from clipboard to terminal
wl-paste

# Copy current working directory path
pwd | wl-copy
```

#### GUI Copy/Paste
```bash
# Standard shortcuts work in most applications:
# Copy: Ctrl + C
# Paste: Ctrl + V
# Cut: Ctrl + X
# Select All: Ctrl + A

# For clipboard history with clipman:
# Add to Hyprland config (~/.config/hypr/hyprland.conf):
# exec-once = wl-paste -t text --watch clipman store
# bind = SUPER, V, exec, clipman pick -t wofi
```

### Advanced Clipboard Features
```bash
# Copy screenshot to clipboard
grim -g "$(slurp)" - | wl-copy

# Copy file path to clipboard (in file manager)
# Right-click → Copy Path (or use ranger/nnn file managers)

# Monitor clipboard changes
wl-paste -w echo "Clipboard changed"

# Clear clipboard
wl-copy --clear
```

## Shared Folders and File Sharing

### Virtual Machine Shared Folders

#### VMware Shared Folders
```bash
# Install VMware tools
sudo pacman -S open-vm-tools

# Enable VMware services
sudo systemctl enable vmtoolsd.service
sudo systemctl start vmtoolsd.service

# Mount shared folders
sudo mkdir /mnt/hgfs
sudo mount -t fuse.vmhgfs-fuse .host:/ /mnt/hgfs -o allow_other

# Auto-mount on boot (add to /etc/fstab)
echo ".host:/ /mnt/hgfs fuse.vmhgfs-fuse allow_other 0 0" | sudo tee -a /etc/fstab
```

#### VirtualBox Shared Folders
```bash
# Install VirtualBox guest additions
sudo pacman -S virtualbox-guest-utils

# Add user to vboxsf group
sudo usermod -aG vboxsf $USER

# Mount shared folder (replace 'SharedFolder' with your folder name)
sudo mkdir /mnt/shared
sudo mount -t vboxsf SharedFolder /mnt/shared

# Auto-mount on boot (add to /etc/fstab)
echo "SharedFolder /mnt/shared vboxsf defaults,uid=1000,gid=1000 0 0" | sudo tee -a /etc/fstab
```

### Network File Sharing

#### SMB/CIFS Shares (Windows shares)
```bash
# Install CIFS utilities
sudo pacman -S cifs-utils

# Create mount point
sudo mkdir /mnt/windows-share

# Mount Windows share
sudo mount -t cifs //server-ip/share-name /mnt/windows-share -o username=your-username

# Permanent mount (add to /etc/fstab)
echo "//server-ip/share-name /mnt/windows-share cifs credentials=/etc/samba/credentials,uid=1000,gid=1000 0 0" | sudo tee -a /etc/fstab
```

#### NFS Shares
```bash
# Install NFS utilities
sudo pacman -S nfs-utils

# Create mount point
sudo mkdir /mnt/nfs-share

# Mount NFS share
sudo mount -t nfs server-ip:/path/to/share /mnt/nfs-share

# Permanent mount (add to /etc/fstab)
echo "server-ip:/path/to/share /mnt/nfs-share nfs defaults 0 0" | sudo tee -a /etc/fstab
```

### Local File Sharing

#### HTTP File Server (Quick sharing)
```bash
# Install Python (usually already installed)
python -m http.server 8000  # Serves current directory on port 8000

# Access from other devices: http://your-ip:8000
```

#### FTP Server
```bash
# Install vsftpd
sudo pacman -S vsftpd

# Configure and start FTP service
sudo systemctl enable vsftpd
sudo systemctl start vsftpd
```

## Troubleshooting Common Issues

### Monitor and Display Issues

#### Monitor Resolution and Size
```bash
# Check current display configuration
wlr-randr

# List available display modes
wlr-randr --output DP-1 --mode 1920x1080@60

# Set custom resolution
wlr-randr --output DP-1 --custom-mode 1920x1080@60

# Scale display (useful for high DPI monitors)
wlr-randr --output DP-1 --scale 1.5

# Multiple monitor setup
wlr-randr --output DP-1 --mode 1920x1080 --pos 0,0 --output HDMI-1 --mode 1920x1080 --pos 1920,0
```

#### Hyprland Display Configuration
```bash
# Edit Hyprland config for permanent display settings
nano ~/.config/hypr/hyprland.conf

# Add monitor configuration (example):
# monitor = DP-1, 1920x1080@60, 0x0, 1
# monitor = HDMI-1, 1920x1080@60, 1920x0, 1

# Reload Hyprland config
hyprctl reload
```

#### Common Display Issues
```bash
# Black screen or no display
# Check if display manager is running
sudo systemctl status sddm

# Check graphics drivers
lspci -k | grep -A 2 -E "(VGA|3D)"

# For NVIDIA users - check if nouveau is blacklisted
lsmod | grep nouveau  # Should return nothing

# Monitor not detected
# Check connected displays
wlr-randr
xrandr  # For X11 fallback

# Force monitor detection
sudo ddcutil detect

# Fix monitor refresh rate issues
# Add to Hyprland config:
# monitor = ,preferred,auto,1,vrr,1
```

### Audio Issues (Expanded)

#### Basic Audio Troubleshooting
```bash
# Check audio devices
pactl list sinks

# Check audio sources (microphones)
pactl list sources

# Set default audio output
pactl set-default-sink sink_name

# Set default audio input
pactl set-default-source source_name

# Restart audio services
systemctl --user restart wireplumber pipewire pipewire-pulse
```

#### Advanced Audio Solutions
```bash
# No audio output
# Check if audio is muted
pactl list sinks | grep -A 10 "State: RUNNING"
amixer get Master

# Unmute audio
pactl set-sink-mute @DEFAULT_SINK@ 0
amixer set Master unmute

# Audio crackling or distortion
# Edit PipeWire config
mkdir -p ~/.config/pipewire
cp /usr/share/pipewire/pipewire.conf ~/.config/pipewire/
nano ~/.config/pipewire/pipewire.conf
# Adjust sample rate and buffer sizes

# HDMI audio not working
# List audio devices
aplay -l
# Enable HDMI audio output
pactl set-card-profile alsa_card.pci-0000_01_00.1 output:hdmi-stereo

# Bluetooth audio issues
# Restart bluetooth service
sudo systemctl restart bluetooth
# Reconnect bluetooth device
bluetoothctl
# power on
# scan on
# connect XX:XX:XX:XX:XX:XX

# Audio delay/latency issues
# Adjust PipeWire latency settings
pw-metadata -n settings 0 clock.force-quantum 512
```

### Network Issues (Comprehensive)

#### Basic Network Diagnostics
```bash
# Check network interface status
ip addr show
ip link show

# Check network connectivity
ping google.com
ping 8.8.8.8  # Test DNS vs connectivity

# Check routing table
ip route show

# Check DNS configuration
cat /etc/resolv.conf
resolvectl status
```

#### WiFi Issues
```bash
# WiFi not connecting
# Check WiFi adapter status
iwctl device list
iwctl station wlan0 show

# Scan for networks
iwctl station wlan0 scan
iwctl station wlan0 get-networks

# Check NetworkManager status (if using)
sudo systemctl status NetworkManager
nmcli device status
nmcli connection show

# Reset network configuration
sudo systemctl restart NetworkManager
sudo systemctl restart systemd-networkd

# WiFi adapter not detected
# Check if WiFi drivers are loaded
lspci -k | grep -A 3 -i network
lsmod | grep -i wifi
dmesg | grep -i wifi

# Manual WiFi connection
wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant.conf
dhcpcd wlan0
```

#### Ethernet Issues
```bash
# Ethernet not working
# Check ethernet adapter
ip link show
ethtool eth0  # Replace eth0 with your interface

# Check cable connection
ethtool eth0 | grep "Link detected"

# Manual IP configuration
sudo ip addr add 192.168.1.100/24 dev eth0
sudo ip route add default via 192.168.1.1
```

#### DNS Issues
```bash
# DNS resolution problems
# Test DNS servers
nslookup google.com 8.8.8.8
dig @8.8.8.8 google.com

# Change DNS servers
# Edit /etc/systemd/resolved.conf
sudo nano /etc/systemd/resolved.conf
# Add: DNS=8.8.8.8 1.1.1.1
sudo systemctl restart systemd-resolved

# Clear DNS cache
sudo systemctl restart systemd-resolved
resolvectl flush-caches

# Alternative DNS configuration
# Edit /etc/resolv.conf
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf
echo "nameserver 1.1.1.1" | sudo tee -a /etc/resolv.conf
```

#### Network Performance Issues
```bash
# Check network speed
speedtest-cli  # Install with: sudo pacman -S speedtest-cli

# Monitor network usage
iftop          # Install with: sudo pacman -S iftop
nethogs        # Install with: sudo pacman -S nethogs

# Check for network congestion
ss -tulpn      # Show listening ports
netstat -tulpn # Alternative

# Reset network stack
sudo systemctl restart NetworkManager
sudo systemctl restart systemd-networkd
sudo systemctl restart systemd-resolved
```

#### Firewall Issues
```bash
# Check if firewall is blocking connections
sudo ufw status
sudo iptables -L

# Temporarily disable firewall for testing
sudo ufw disable
# Remember to re-enable: sudo ufw enable

# Allow specific ports
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow ssh
```

### Graphics Issues
```bash
# Check loaded graphics modules
lsmod | grep -i nvidia  # For NVIDIA
lsmod | grep -i amd     # For AMD

# Rebuild initramfs (after driver changes)
sudo mkinitcpio -P
```

### Boot Issues
```bash
# Check boot loader
sudo bootctl status

# Update GRUB (if using GRUB)
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

## Performance Optimization

### Enable SSD TRIM (for SSDs)
```bash
# Enable weekly TRIM
sudo systemctl enable fstrim.timer
```

### Optimize Pacman
Edit `/etc/pacman.conf` and uncomment the following lines for parallel downloads and a more verbose package list. The `Color` option is usually enabled by default.

```bash
ParallelDownloads = 5
Color
VerbosePkgLists
```

## Security Basics

### Firewall
```bash
# Install and enable UFW firewall
sudo pacman -S --noconfirm ufw
sudo ufw enable

# Check firewall status
sudo ufw status
```

### Updates and Security
```bash
# Always keep system updated
sudo pacman -Syu

# Check for failed services
systemctl --failed

# Check system integrity
sudo pacman -Qkk
```

## Additional Resources

- [Arch Linux Wiki](https://wiki.archlinux.org/)
- [Hyprland Documentation](https://hyprland.org/)
- [Arch Linux Forums](https://bbs.archlinux.org/)

Remember to read the Arch Wiki - it's one of the best Linux documentation resources available!