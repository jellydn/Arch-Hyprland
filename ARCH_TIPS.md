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