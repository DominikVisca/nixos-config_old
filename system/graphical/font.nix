{ lib, pkgs, ... }:

{
  fonts = {
    fonts = with pkgs; [
      powerline-fonts
      fira
      eb-garamond
      fira-code # monospace
      (nerdfonts.override {
          fonts = [ "FiraCode" ]; # monospace font with nerd patches
      })
      noto-fonts-emoji # support emoji
    ];

    fontconfig.defaultFonts = {
      monospace = [ "FiraCode Nerd Font" ];
      # monospace = [ "Fira Code" ];
      serif = [ "EB Garamond" ];
      sansSerif = [ "Fira Sans" ];
    };
  };
}