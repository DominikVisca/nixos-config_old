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
      #./graphical/gnome.nix
      ./graphical/awesome.nix
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
  networking.networkmanager.enable = true;
  networking.useDHCP = false;

  # Enable sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # User
  users.users.dv = {
    isNormalUser = true;
    initialPassword = "dv_pass";
    extraGroups = [ "wheel" "networkmanager" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    vim
    wget
  ];

  # Install fonts
  fonts.fonts = with pkgs; [
    nerdfonts
  ];

  # System-wide services
  services.acpid.enable = true;
  services.avahi.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
}

