{ ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = "set fish_greeting";
    loginShellInit = ''
      if test -z "$WAYLAND_DISPLAY"; and test "$XDG_VTNR" = 1
        exec niri --session
      end
    '';

    functions = {
      ncg = "sudo nix-collect-garbage -d";
      nrs = "sudo nixos-rebuild switch --flake ~/Nixos#(hostname)";
    };
  };
}
