{ pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  # Boot
  boot.loader = {
    limine.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Networking
  networking = {
    hostName = "nixos-btw";
    networkmanager.enable = true;
  };

  # Hardware and audio
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Locale
  time.timeZone = "Europe/Sofia";

  # User account
  users.users.imbir = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "input" "bluetooth" ];
  };

  # Desktop environment
  nixpkgs.config.allowUnfree = true;
  powerManagement.cpuFreqGovernor = "performance";

  programs.niri.enable = true;
  programs.fish.enable = true;
  security.polkit.enable = true;

  services.getty.autologinUser = "imbir";

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
  };

  # Nix maintenance
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 3d";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "26.05";
}
