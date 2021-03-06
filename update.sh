#! /usr/bin/env bash

# Define host
HOSTFILE="thinkpad-e580.nix"

# Shows the output of every command
set +x

# Copy configuration files
sudo cp system/configuration.nix /etc/nixos/
sudo cp -r system/host/ /etc/nixos
sudo cp -r system/graphical/ /etc/nixos
sudo mv /etc/nixos/host/$HOSTFILE /etc/nixos/host/current.nix
sudo nixos-rebuild switch

# Copy home manager files
cp -r home/* $HOME/.config/nixpkgs/
home-manager switch

# Copy dotfiles
# awesome
rm -rf $HOME/.config/awesome
cp -r awesome/ $HOME/.config

## firefox
rm -rf $HOME/.mozilla/firefox/default/chrome
cp -r dotfiles/firefox $HOME/.mozilla/firefox/default
mv $HOME/.mozilla/firefox/default/firefox $HOME/.mozilla/firefox/default/chrome

## kitty
rm -rf $HOME/.config/kitty
cp -r dotfiles/kitty/ $HOME/.config

## rofi
rm -rf $HOME/.config/rofi
cp -r dotfiles/rofi/ $HOME/.config

## assets
rm -rf $HOME/.config/assets
cp -r assets/ $HOME/.config