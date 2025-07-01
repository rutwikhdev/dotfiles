> [!WARNING]  
> Ansible setup is still WIP and might break anytime so use at your own risk

<p align="center">Dotfiles for my reproducible os/dev env setup with Hyprland</p>

![image](https://github.com/user-attachments/assets/edf4b43d-3fad-4de4-8ebd-e3912421ebc9)


### Installation on Arch/Ubuntu/Fedora
```bash
# Install ansible using the default package manager for your distro and run,
git clone https://github.com/rutwikhdev/dotfiles.git
cd dotfiles
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
