#!/bin/bash

# Fonts
mkdir -p ~/.local/share/fonts/
ln -s -f $(pwd)/fonts/PTMono-NerdFont-Regular.ttf ~/.local/share/fonts/PTMono-NerdFont-Regular.ttf

# Git
ln -s -f $(pwd)/git/gitconfig ~/.gitconfig

# i3
mkdir -p ~/.config/i3/
ln -s -f $(pwd)/i3/config ~/.config/i3/config

# Nvim
mkdir -p ~/.config/nvim/
ln -s -f $(pwd)/nvim/init.vim ~/.config/nvim/init.vim

# Plasma
mkdir -p ~/.config/autostart-scripts/
mkdir -p ~/.config/plasma-workspace/env/
ln -s -f $(pwd)/plasma/ssh-add.sh ~/.config/autostart-scripts/ssh-add.sh
ln -s -f $(pwd)/plasma/ssh-askpass.sh ~/.config/plasma-workspace/env/ssh-askpass.sh
ln -s -f $(pwd)/plasma/wm.sh ~/.config/plasma-workspace/env/wm.sh

# Tmux
ln -s -f $(pwd)/tmux/tmux.conf ~/.tmux.conf

# Wallpapers
mkdir -p ~/.wallpaper
cp $(pwd)/wallpaper/* ~/.wallpaper/

# X11
ln -s -f $(pwd)/X11/xinitrc ~/.xinitrc

# Zsh
mkdir -p ~/.oh-my-zsh/custom/themes/
ln -s -f $(pwd)/zsh/zshrc ~/.zshrc
ln -s -f $(pwd)/zsh/oxide.zsh-theme ~/.oh-my-zsh/custom/themes/oxide.zsh-theme

# Colored ls
ln -s -f $(pwd)/dircolors ~/.dircolors

# Systemd
mkdir -p ~/.config/systemd/user/
ln -s -f $(pwd)/systemd/wallpaper.service ~/.config/systemd/user/wallpaper.service
ln -s -f $(pwd)/systemd/wallpaper.timer ~/.config/systemd/user/wallpaper.timer

# Starts systemd services
systemctl --user enable wallpaper.{service,timer}
systemctl --user start wallpaper.{service,timer}
