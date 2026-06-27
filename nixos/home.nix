{ pkgs, userName ? "nixos-user", userEmail ? "replace-me", ... }:

let
  cursorTheme = "ZUTOMAYO-Pixel-2x";
  cursorSize = 48;
in
{
  home.username = userName;
  home.homeDirectory = "/home/${userName}";
  home.stateVersion = "25.05";

  programs.git = {
    enable = true;
    settings.user.name = userName;
    settings.user.email = userEmail;
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "eza";
      ll = "eza -lah";
      cat = "bat";
      diag = "inxi -Fazy";
      rebuild = "sudo nixos-rebuild switch --flake \${NIXOS_FLAKE:-/etc/nixos}";
      nconf = "\${EDITOR:-kate} \${NIXOS_FLAKE:-/etc/nixos}/configuration.nix";
      hconf = "\${EDITOR:-kate} \${NIXOS_FLAKE:-/etc/nixos}/home.nix";
    };
  };

  programs.bat.enable = true;
  programs.eza.enable = true;

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  home.packages = with pkgs; [
    bottom
    ncdu
    dust
    procs
    jq
    tealdeer
    killall
    bluez
    libnotify
    pulseaudio # pactl for the Waybar volume helper
  ];

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = cursorTheme;
    size = cursorSize;

    package = pkgs.stdenvNoCC.mkDerivation {
      name = "zutomayo-pixel-cursors-2x";
      src = ./cursors/ZUTOMAYO-Pixel-2x;

      installPhase = "mkdir -p $out/share/icons/${cursorTheme}\ncp -r . $out/share/icons/${cursorTheme}\n";
    };
  };

  home.sessionPath = [
    "$HOME/.codex/bin"
    "$HOME/.local/bin"
  ];

  home.sessionVariables = {
    NIXOS_FLAKE = "/etc/nixos";
    XCURSOR_THEME = cursorTheme;
    XCURSOR_SIZE = toString cursorSize;
  };
}
