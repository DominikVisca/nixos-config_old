{ config, pkgs, lib, ... }:

{
  imports = [
    ./font.nix
  ];

  # High-DPI + powerline console font (already for boot and luks)
  console = {
    packages = [ pkgs.powerline-font ];
    font = "ter-powerline-v24n";
    earlySetup = true;
  };
}