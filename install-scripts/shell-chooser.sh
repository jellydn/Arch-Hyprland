#!/bin/bash
# 💫 https://github.com/jellydn/Arch-Hyprland 💫 #
# Shell chooser - Set your default shell after installation #

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
LOG="Install-Logs/install-$(date +%d-%H%M%S)_shell-chooser.log"

printf "\n%s - ${SKY_BLUE}Shell Chooser${RESET} .... \n" "${NOTE}"
echo "${INFO} Current shell: $(basename "$SHELL")" 2>&1 | tee -a "$LOG"

# Check what shells are installed
shells_installed=()
if command -v zsh >/dev/null; then
    shells_installed+=("zsh")
fi
if command -v fish >/dev/null; then
    shells_installed+=("fish")
fi
if command -v bash >/dev/null; then
    shells_installed+=("bash")
fi

if [ ${#shells_installed[@]} -eq 0 ]; then
    echo "${ERROR} No supported shells found!" 2>&1 | tee -a "$LOG"
    exit 1
fi

echo "${INFO} Available shells:" 2>&1 | tee -a "$LOG"
for shell in "${shells_installed[@]}"; do
    echo "  • $shell" 2>&1 | tee -a "$LOG"
done

# Create whiptail menu for shell selection
shell_options=()
for shell in "${shells_installed[@]}"; do
    if [ "$shell" = "zsh" ]; then
        shell_options+=("$shell" "Zsh with Oh-My-Zsh (feature-rich, customizable)" "OFF")
    elif [ "$shell" = "fish" ]; then
        shell_options+=("$shell" "Fish shell (user-friendly, smart autocompletion)" "OFF")
    elif [ "$shell" = "bash" ]; then
        shell_options+=("$shell" "Bash (default, widely compatible)" "OFF")
    fi
done

# Show whiptail menu
chosen_shell=$(whiptail --title "Shell Selection" --radiolist \
"Choose your default shell:" 15 80 5 \
"${shell_options[@]}" 3>&1 1>&2 2>&3)

if [ $? -eq 0 ] && [ -n "$chosen_shell" ]; then
    printf "${NOTE} Setting default shell to ${MAGENTA}$chosen_shell${RESET}...\n" 2>&1 | tee -a "$LOG"
    
    # Loop to ensure the chsh command succeeds
    while ! chsh -s "$(command -v $chosen_shell)"; do
        echo "${ERROR} Authentication failed. Please enter the correct password." 2>&1 | tee -a "$LOG"
        sleep 1
    done
    
    printf "${OK} Shell changed successfully to ${MAGENTA}$chosen_shell${RESET}!\n" 2>&1 | tee -a "$LOG"
    echo "${INFO} Please log out and back in for the change to take effect." 2>&1 | tee -a "$LOG"
    
    if [ "$chosen_shell" = "zsh" ]; then
        echo "${INFO} Zsh features: Oh-My-Zsh, plugins, themes" 2>&1 | tee -a "$LOG"
    elif [ "$chosen_shell" = "fish" ]; then
        echo "${INFO} Fish features: Smart autocompletion, syntax highlighting, web config" 2>&1 | tee -a "$LOG"
        if command -v fish_config >/dev/null 2>&1; then
            echo "${INFO} Try: fish_config (web-based configuration)" 2>&1 | tee -a "$LOG"
        else
            echo "${INFO} Run 'fish' to start using Fish shell" 2>&1 | tee -a "$LOG"
        fi
    fi
else
    echo "${NOTE} No shell selected. Current shell unchanged." 2>&1 | tee -a "$LOG"
fi

printf "\n%.0s" {1..2}