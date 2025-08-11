#!/bin/bash
# 💫 https://github.com/jellydn/Arch-Hyprland 💫 #
# Foot terminal installation #

foot_pkg=(
  foot
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
LOG="Install-Logs/install-$(date +%d-%H%M%S)_foot.log"

# Installing foot packages
printf "\n%s - Installing ${SKY_BLUE}Foot terminal${RESET} .... \n" "${NOTE}"
for FOOT in "${foot_pkg[@]}"; do
  install_package "$FOOT" "$LOG"
done 

# Configure foot if installed successfully
if command -v foot >/dev/null; then
  printf "${NOTE} ${SKY_BLUE}Foot${RESET} installed successfully.\n"
  
  # Create foot configuration directory if it doesn't exist
  mkdir -p "$HOME/.config/foot"
  
  # Copy configuration if available in assets
  if [ -f "assets/foot/foot.ini" ]; then
    echo "${INFO} Copying Foot configuration from assets..." 2>&1 | tee -a "$LOG"
    cp -r assets/foot/* "$HOME/.config/foot/"
  elif [ -d "assets/foot" ]; then
    echo "${INFO} Foot configuration files found in assets. You can customize them manually." 2>&1 | tee -a "$LOG"
  else
    echo "${NOTE} No Foot configuration found in assets. Creating basic config..." 2>&1 | tee -a "$LOG"
    
    # Create a basic foot.ini configuration optimized for VMs and general use
    cat > "$HOME/.config/foot/foot.ini" << 'EOF'
# Foot Terminal Configuration
# Lightweight, fast, and VM-friendly terminal

[main]
# Font configuration
font=monospace:size=10

# Terminal size
initial-window-size-pixels=1024x768

# Performance optimizations for VMs
pad=8x8

[mouse]
hide-when-typing=yes

[colors]
# Dark theme (easy on eyes in VMs)
foreground=c5c8c6
background=1d1f21

# Normal colors
regular0=282a2e  # black
regular1=a54242  # red
regular2=8c9440  # green
regular3=de935f  # yellow
regular4=5f819d  # blue
regular5=85678f  # magenta
regular6=5e8d87  # cyan
regular7=707880  # white

# Bright colors
bright0=373b41   # bright black
bright1=cc6666   # bright red
bright2=b5bd68   # bright green
bright3=f0c674   # bright yellow
bright4=81a2be   # bright blue
bright5=b294bb   # bright magenta
bright6=8abeb7   # bright cyan
bright7=c5c8c6   # bright white

[key-bindings]
# Common keybindings
clipboard-copy=Control+Shift+c
clipboard-paste=Control+Shift+v
primary-paste=Shift+Insert
search-start=Control+Shift+r
font-increase=Control+plus Control+equal
font-decrease=Control+minus
font-reset=Control+0
spawn-terminal=Control+Shift+n
fullscreen=F11

[search-bindings]
# Search mode bindings
cancel=Control+g Control+c Escape
commit=Return
find-prev=Control+r
find-next=Control+s
cursor-left=Left Control+b
cursor-right=Right Control+f
cursor-home=Home Control+a
cursor-end=End Control+e
delete-prev=BackSpace
delete-next=Delete

[url]
# URL handling
launch=xdg-open \${url}
protocols=http, https, ftp, ftps, file

[scrollback]
lines=10000
multiplier=3.0

[bell]
urgent=no
notify=no
visual=no

[desktop-notifications]
command=notify-send -a \${app-id} -i \${app-id} \${title} \${body}
close-on-exit=yes
inhibit-when-focused=yes
EOF
    
    echo "${INFO} Basic Foot configuration created at ~/.config/foot/foot.ini" 2>&1 | tee -a "$LOG"
    echo "${INFO} Foot is lightweight and perfect for VM usage - minimal GPU requirements." 2>&1 | tee -a "$LOG"
  fi
  
fi

printf "\n%.0s" {1..2}