Dotfile configs for reproducible os/dev env setup

### Arch/Ubuntu/Fedora + Hyprland setup using Ansible
```bash
# Install ansible using the default package manager for your distro and run,
sudo ansible-playbook main.yml --become
```

### Roles
##### You can enable and disable them based on what you need
- essential - essential packages required for hyprland and development setup
- zsh - minimal zsh setup with oh-my-zsh and auto-suggestion plugin (you might need to restart/logout after setting zsh as default shell)
- keyd - my keyboard remaps using [keyd](https://github.com/rvaiya/keyd)
- dotfiles - creates symlinks for dotfiles
- git - basic git config(disabled by default)
- flathub - install flatpak apps that I use. WIP
