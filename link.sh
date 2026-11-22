#!/bin/bash

# Interactive linker: asks for each section whether you want to link it.
# Would be cool to use OSTYPE env var here to handle different OSs.

ask() {
    local label="$1"
    local answer
    printf '%s [y/N] ' "$label"
    read -r answer
    case "$answer" in
        [yY]|[yY][eE][sS]) return 0 ;;
        *) return 1 ;;
    esac
}

# Fonts
if ask "Link fonts?"; then
    mkdir -p ~/.local/share/fonts/
    ln -s -f "$(pwd)/fonts/PTMono-NerdFont-Regular.ttf" ~/.local/share/fonts/PTMono-NerdFont-Regular.ttf
fi

# Git
if ask "Link git config?"; then
    ln -s -f "$(pwd)/git/gitconfig" ~/.gitconfig
fi

# i3
if ask "Link i3 config?"; then
    mkdir -p ~/.config/i3/
    ln -s -f "$(pwd)/i3/config" ~/.config/i3/config
fi

# Nvim
if ask "Link nvim config?"; then
    mkdir -p ~/.config/nvim/
    ln -s -f "$(pwd)/nvim/init.vim" ~/.config/nvim/init.vim
fi

# Plasma
if ask "Link Plasma scripts?"; then
    mkdir -p ~/.config/autostart-scripts/
    mkdir -p ~/.config/plasma-workspace/env/
    ln -s -f "$(pwd)/plasma/ssh-add.sh" ~/.config/autostart-scripts/ssh-add.sh
    ln -s -f "$(pwd)/plasma/ssh-askpass.sh" ~/.config/plasma-workspace/env/ssh-askpass.sh
fi

# xfce4-terminal
if ask "Link xfce4-terminal config?"; then
    mkdir -p ~/.config/xfce4/terminal/colorschemes
    ln -s -f "$(pwd)/xfce4/terminal/accels.scm" ~/.config/xfce4/terminal/accels.scm
    ln -s -f "$(pwd)/xfce4/terminal/colorschemes/base16-gruvbox-dark-hard.theme" ~/.config/xfce4/terminal/colorschemes/base16-gruvbox-dark-hard.theme
    ln -s -f "$(pwd)/xfce4/terminal/colorschemes/base16-solarized-light.theme" ~/.config/xfce4/terminal/colorschemes/base16-solarized-light.theme
    ln -s -f "$(pwd)/xfce4/terminal/terminalrc" ~/.config/xfce4/terminal/terminalrc
fi

# Tmux
if ask "Link tmux config?"; then
    ln -s -f "$(pwd)/tmux/tmux.conf" ~/.tmux.conf
fi

# Wallpapers
if ask "Copy wallpapers?"; then
    mkdir -p ~/.wallpaper
    cp "$(pwd)"/wallpaper/* ~/.wallpaper/
fi

# X11
if ask "Link X11 config?"; then
    ln -s -f "$(pwd)/X11/xinitrc" ~/.xinitrc
fi

# Zsh
if ask "Link zsh config?"; then
    mkdir -p ~/.oh-my-zsh/custom/themes/
    ln -s -f "$(pwd)/zsh/zshrc" ~/.zshrc
    ln -s -f "$(pwd)/zsh/oxide.zsh-theme" ~/.oh-my-zsh/custom/themes/oxide.zsh-theme
fi

# Fish
if ask "Link fish config?"; then
    mkdir -p ~/.config/fish/
    ln -s -f "$(pwd)/fish/config.fish" ~/.config/fish/config.fish
fi

# Colored ls
if ask "Link dircolors?"; then
    ln -s -f "$(pwd)/dircolors" ~/.dircolors
fi

# Systemd
if ask "Link systemd wallpaper files?"; then
    mkdir -p ~/.config/systemd/user/
    ln -s -f "$(pwd)/systemd/wallpaper.service" ~/.config/systemd/user/wallpaper.service
    ln -s -f "$(pwd)/systemd/wallpaper.timer" ~/.config/systemd/user/wallpaper.timer
fi

# i3 on Plasma
if ask "Set up i3 on Plasma (mask kwin, enable plasma-i3.service)?"; then
    systemctl --user mask plasma-kwin_x11.service
    ln -s -f "$(pwd)/plasma/plasma-i3.service" ~/.config/systemd/user/plasma-i3.service
    systemctl --user enable plasma-i3.service
fi

# Starts systemd services
if ask "Enable and start wallpaper services?"; then
    systemctl --user enable wallpaper.{service,timer}
    systemctl --user start wallpaper.{service,timer}
fi
