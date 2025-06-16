#!/bin/bash
set -e

echo "UPDATING SYSTEM..."
sudo pacman -Syu --noconfirm

echo "Installing base-devel, git, curl, and neovim..."
sudo pacman -S --noconfirm base-devel git curl neovim tmux chezmoi

echo "Setting up .bash_profile"
if [ ! -f "$HOME/.bash_profile" ]; then
	touch ~/.bash_profile
	echo "[[ -f ~/.bashrc ]] && . ~/.bashrc"
else
	echo ".bash_profile already exists"
fi

echo "Installing Oh My Bash..."
if [ ! -d "$HOME/.oh-my-bash" ]; then
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
else
	echo "Oh My Bash already installed"
fi

echo "Chezmoi-ing this shiz up"
chezmoi init --apply git@github.com:jgarner9/dotfiles.git

echo "Completado"
