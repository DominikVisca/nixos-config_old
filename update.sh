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