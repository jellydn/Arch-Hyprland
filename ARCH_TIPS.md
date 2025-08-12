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
echo "//server-ip/share-name /mnt/windows-share cifs username=your-username,password=your-password,uid=1000,gid=1000 0 0" | sudo tee -a /etc/fstab
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

### Audio Issues
```bash
# Check audio devices
pactl list sinks

# Set default audio output
pactl set-default-sink sink_name

# Restart audio service
systemctl --user restart pipewire
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
Edit `/etc/pacman.conf`:
```bash
# Uncomment these lines for better performance
ParallelDownloads = 5
Color
VerbosePkgLists
```

## Security Basics

### Firewall
```bash
# Enable UFW firewall
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