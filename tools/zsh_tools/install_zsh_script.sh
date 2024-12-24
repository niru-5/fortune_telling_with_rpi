#!/bin/bash

# Check if the script is run as root
# if [[ $EUID -eq 0 ]]; then
#     echo "This script should not be run as root. Please run it as a normal user."
#     exit 1
# fi

# Update and install Zsh
echo "Updating package list and installing Zsh..."
apt update && apt install -y zsh || { echo "Failed to install Zsh"; exit 1; }

# Verify installation
if ! command -v zsh >/dev/null 2>&1; then
    echo "Zsh installation failed. Aborting."
    exit 1
fi

echo "Zsh successfully installed."

# Install Oh My Zsh
echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || { echo "Oh My Zsh installation failed"; exit 1; }

# Install zsh-syntax-highlighting
echo "Installing zsh-syntax-highlighting..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting || { echo "Failed to clone zsh-syntax-highlighting"; exit 1; }

# Install zsh-autosuggestions
echo "Installing zsh-autosuggestions..."
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions || { echo "Failed to clone zsh-autosuggestions"; exit 1; }

# Configure .zshrc to enable plugins
echo "Configuring .zshrc to enable plugins..."
sed -i '/^plugins=(/ s/)/ zsh-syntax-highlighting zsh-autosuggestions)/' ~/.zshrc || {
    echo "Failed to configure .zshrc";
    exit 1;
}

# Change the default shell to Zsh
echo "Changing default shell to Zsh..."
chsh -s $(which zsh) || { echo "Failed to change default shell"; exit 1; }

echo "Installation complete! Please restart your terminal or log out and back in to start using Zsh."
