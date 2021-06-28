{ config, pkgs, lib, ... }:

{
  services.xserver.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.layout = "de";

  environment.systemPackages = with pkgs.gnome; [
    dconf-editor
    gnome-tweaks    
  ];

  environment.gnome.excludePackages = with pkgs.gnome; [
    gedit
    gnome-weather
    gnome-maps
    gnome-terminal
    gnome-software
    gnome-music
    totem
    epiphany
    geary
  ];

  #environment.systemPackages = with pkgs.gnomeExtensions; [
  #  appindicator
  #  blur-my-shell
  #  #gnome-ui-tune
  #  just-perfection
  #  #pop-os-shell 
  #];

  # Exclude some default applications
  # environment.gnome.excludePackages = with pkgs.gnome3; [
  #     gnome-weather
  #     gnome-maps
  #     gnome-software
  #     totem
  #     epiphany
  # ];
  
  # programs.gnome-terminal.enable = false;
  # programs.geary.enable = false;
  
  # Conflicts with tlp
  services.power-profiles-daemon.enable = false;

}