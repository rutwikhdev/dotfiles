#!/bin/bash


# key mapper
if [ "$1" == "--modules" ]; then
  if [ "$2" == "utils" ] || [ "$2" == "all" ]; then
    sudo apt install \
      nvim \
      tmux \
      fzf \
      ripgrep \
      golang \
      font-manager \
      nodejs \
      npm
  fi
  if [ "$2" == "sway" ] || [ "$2" == "all" ]; then
    sudo apt install \
      sway \
      waybar \
      wlr-randr \
      wl-copy \
      xdg-desktop-portal-wlr
    cp -r ../.config/sway ~/.config/sway
    cp -r ../.config/waybar ~/.config/waybar
  fi
  if [ "$2" == "keyd" ] || [ "$2" == "all" ]; then
    cd /tmp
    git clone https://github.com/rvaiya/keyd
    cd keyd
    make && sudo make install
    sudo systemctl enable keyd && sudo systemctl start keyd
    sudo cp -r ../.config/keyd/default.conf /etc/keyd/
  fi
else
  echo "Usage: $0 --modules [module_name] | [all]"
fi
