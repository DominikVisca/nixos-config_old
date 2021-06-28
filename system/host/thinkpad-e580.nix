{ config, pkgs, ... }:

{
  # Boot loader (systemd)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # LUKS
  boot.initrd.luks.devices = {
    crypted = {
      device = "/dev/disk/by-uuid/d9ff8e5d-0d7d-471d-9a0e-2a501a822755";
      preLVM = true;
    };
  };

  # Network
  networking.hostName = "ucuri";
  networking.interfaces.enp3s0.useDHCP = true;
  networking.interfaces.wlp5s0.useDHCP = true;
}