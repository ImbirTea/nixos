{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Command-line tools
    bat
    bluetui
    btop
    fastfetch
    brightnessctl
    fzf
    git
    libnotify
    neovim
    playerctl
    sl
    tree
    wget
    rustup
    gcc

    # Desktop applications
    firefox
    kitty
    nwg-look
    obsidian
    pwvucontrol
    steam
    telegram-desktop
    vscodium
    zed-editor
    prismlauncher

    # Wayland session components
    awww
    mako
    polkit_gnome
    quickshell
    rofi
    swaylock
    wl-clipboard
    xwayland-satellite
  ];

}
