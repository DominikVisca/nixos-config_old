{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    layout = "de";

    displayManager = {
      gdm.enable = true;
      defaultSession = "none+awesome";
    };

    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks
      ];
    };
  };
}