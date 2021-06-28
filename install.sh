#! /usr/bin/env bash
# Define host
HOSTFILE="thinkpad-e580.nix"

# Copy configuration files
sudo cp system/configuration.nix /etc/nixos/
sudo cp -r system/host/ /etc/nixos
sudo cp -r system/graphical/ /etc/nixos
sudo mv /etc/nixos/host/$HOSTFILE /etc/nixos/host/current.nix
sudo nixos-rebuild switch

# Install home manager
nix-channel --add https://github.com/nix-community/home-manager/archive/release-21.05.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

# Copy home manager files
mkdir -p $HOME/.config/nixpkgs
cp -r home/* $HOME/.config/nixpkgs/
home-manager switch