# Fish shell configuration
# Generated for KooL Arch-Hyprland

# Set environment variables
set -gx EDITOR nano
set -gx BROWSER brave
set -gx TERMINAL ghostty

# Add common paths
fish_add_path ~/.local/bin

# Enable vi key bindings
fish_vi_key_bindings

# Color scheme - use a modern color scheme
set -g fish_color_normal normal
set -g fish_color_command blue
set -g fish_color_quote yellow
set -g fish_color_redirection cyan --bold
set -g fish_color_end green
set -g fish_color_error red --bold
set -g fish_color_param cyan
set -g fish_color_comment brblack
set -g fish_color_match --background=brblue
set -g fish_color_selection white --bold --background=brblack
set -g fish_color_search_match bryellow --background=brblack
set -g fish_color_history_current --bold
set -g fish_color_operator brcyan
set -g fish_color_escape brcyan --bold
set -g fish_color_cwd green
set -g fish_color_cwd_root red
set -g fish_color_valid_path --underline
set -g fish_color_autosuggestion brblack
set -g fish_color_user brgreen
set -g fish_color_host normal
set -g fish_color_cancel -r
set -g fish_pager_color_completion normal
set -g fish_pager_color_description yellow --italics
set -g fish_pager_color_prefix white --bold --underline
set -g fish_pager_color_progress brwhite --background=cyan

# Abbreviations (similar to aliases)
abbr -a ll 'lsd -l'
abbr -a la 'lsd -la'
abbr -a ls 'lsd'
abbr -a tree 'lsd --tree'
abbr -a cat 'bat'
abbr -a grep 'rg'
abbr -a find 'fd'
abbr -a vim 'nvim'
abbr -a vi 'nvim'

# Git abbreviations
abbr -a gs 'git status'
abbr -a ga 'git add'
abbr -a gc 'git commit'
abbr -a gp 'git push'
abbr -a gl 'git pull'
abbr -a gd 'git diff'
abbr -a gb 'git branch'
abbr -a gco 'git checkout'

# System shortcuts
abbr -a .. 'cd ..'
abbr -a ... 'cd ../..'
abbr -a .... 'cd ../../..'
abbr -a cls 'clear'
abbr -a h 'history'

# Package management shortcuts
abbr -a pacup 'sudo pacman -Syu'
abbr -a pacin 'sudo pacman -S'
abbr -a pacrem 'sudo pacman -Rns'
abbr -a pacsearch 'pacman -Ss'

# Function to display system information
function sysinfo
    echo "System Information:"
    echo "=================="
    hostnamectl
    echo ""
    echo "Memory Usage:"
    free -h
    echo ""
    echo "Disk Usage:"
    df -h /
end

# Function to extract various archive types
function extract
    if test -f $argv[1]
        switch $argv[1]
            case '*.tar.bz2'
                tar xjf $argv[1]
            case '*.tar.gz'
                tar xzf $argv[1]
            case '*.bz2'
                bunzip2 $argv[1]
            case '*.rar'
                unrar x $argv[1]
            case '*.gz'
                gunzip $argv[1]
            case '*.tar'
                tar xf $argv[1]
            case '*.tbz2'
                tar xjf $argv[1]
            case '*.tgz'
                tar xzf $argv[1]
            case '*.zip'
                unzip $argv[1]
            case '*.Z'
                uncompress $argv[1]
            case '*.7z'
                7z x $argv[1]
            case '*'
                echo "'$argv[1]' cannot be extracted via extract()"
        end
    else
        echo "'$argv[1]' is not a valid file"
    end
end

# Function to create a directory and cd into it
function mkcd
    mkdir -p $argv[1] && cd $argv[1]
end

# Welcome message
function fish_greeting
    echo "Welcome to Fish Shell!"
    echo "KooL Arch-Hyprland Configuration"
    echo ""
    fastfetch
end

# Initialize any additional configurations
if test -f ~/.config/fish/local.fish
    source ~/.config/fish/local.fish
end