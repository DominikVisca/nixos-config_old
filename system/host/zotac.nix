{ config, pkgs, ... }:

{
  # Boot loader (systemd)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # LUKS
  boot.initrd.luks.devices = {
    crypted = {
      device = "/dev/disk/by-uuid/e9fd1313-f7f7-4d76-b9c4-5a2570b1457f";
      preLVM = true;
    };
  };

  # Network
  networking.hostName = "zotac";
  # networking.wireless.enable = true; # wpa_supplicant
  networking.interfaces.enp1s0.useDHCP = true;
  networking.interfaces.enp2s0.useDHCP = true;
  networking.interfaces.wlp0s12f0.useDHCP = true;
}