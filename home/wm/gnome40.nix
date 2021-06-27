{config, pkgs, lib, ... }:
  let
    mkTuple = lib.hm.gvariant.mkTuple;
  in
{
 # home.packages = with pkgs; [
 #   gnome3.gnome-tweak-tool
 #   gnome3.dconf-editor
 #   dconf2nix
 # ];

  dconf.enable = true;  

  dconf.settings = {
    "system/locale" = {
      region = "de_DE.UTF-8";
    };

    "org/gnome/desktop/input-sources" = {
      sources = [ (mkTuple [ "xkb" "de" ]) ];
    };
  };
}