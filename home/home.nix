{ ... }:

{
  imports = [
    ./cursor.nix
    ./fish.nix
    ./fonts.nix
    ./packages.nix
    ./symlinks.nix
  ];

  home.username = "imbir";
  home.homeDirectory = "/home/imbir";
  home.stateVersion = "26.05";
}
