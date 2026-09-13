{ config, ... }:
let
  dotfiles = "${config.home.homeDirectory}/Nixos/config";
  configs = {
    kitty = "kitty";
    mako = "mako";
    mozilla = "mozilla";
    niri = "niri";
    quickshell = "quickshell";
  };
in
{
  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${subpath}";
      recursive = true;
    }) configs;
}
