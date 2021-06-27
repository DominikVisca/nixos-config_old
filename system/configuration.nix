# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{ 
  # BASE CONFIG
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # Host-specific configuration
      ./host/current.nix

      # Desktop Environment/Window Manager
      #./graphical/kde.nix
      ./graphical/gnome40.nix
    ];
  
  # Localization
  time.timeZone = "Europe/Berlin";

  # Localization only for pure shell  
  i18n.defaultLocale = "de_DE.UTF-8";
  console = {
    font = "lat9w-16";
    keyMap = "de-latin1";
  };

  # Networking
  networking.useDHCP = false;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # User
  users.users.dv = {
    isNormalUser = true;
    initialPassword = "dv_pass";
    extraGroups = [ "wheel" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    vim
    wget
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
}

