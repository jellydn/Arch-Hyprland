# Monitor Configuration Files

Pre-configured monitor settings for different VM environments and resolutions.

## Usage

Copy the appropriate config file to your Hyprland configuration:

```bash
# For VMware Fusion 1080p
cp assets/monitor-configs/vmware-1080p.conf ~/.config/hypr/monitors.conf

# Or source it in your hyprland.conf
echo "source = ~/Projects/research/Arch-Hyprland/assets/monitor-configs/vmware-1080p.conf" >> ~/.config/hypr/hyprland.conf
```

## Available Configurations

- **vmware-1080p.conf** - Optimized for VMware Fusion at 1920x1080 with 1.25x scaling
- More configurations can be added for different VM types and resolutions

## VM-Specific Optimizations

Each config includes:
- Proper resolution and refresh rate settings
- VM-optimized scaling factors
- Hardware cursor disabled for stability
- Software rendering enabled when needed