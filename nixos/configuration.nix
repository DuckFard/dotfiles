{ pkgs, driftwmPackage, userName ? "nixos-user", hostName ? "nixos", ... }:

let
  cursorTheme = "ZUTOMAYO-Pixel-2x";
  cursorSize = 48;
in
{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    inherit hostName;
    networkmanager.enable = true;
  };

  time.timeZone = "Asia/Seoul";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ko_KR.UTF-8";
    LC_IDENTIFICATION = "ko_KR.UTF-8";
    LC_MEASUREMENT = "ko_KR.UTF-8";
    LC_MONETARY = "ko_KR.UTF-8";
    LC_NAME = "ko_KR.UTF-8";
    LC_NUMERIC = "ko_KR.UTF-8";
    LC_PAPER = "ko_KR.UTF-8";
    LC_TELEPHONE = "ko_KR.UTF-8";
    LC_TIME = "ko_KR.UTF-8";
  };

  fonts.packages = with pkgs; [
    nerd-fonts.commit-mono
  ];

  environment.sessionVariables = {
    XCURSOR_THEME = cursorTheme;
    XCURSOR_SIZE = toString cursorSize;
  };

  systemd.user.settings.Manager.DefaultEnvironment = [
    "XCURSOR_THEME=${cursorTheme}"
    "XCURSOR_SIZE=${toString cursorSize}"
  ];

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.displayManager = {
    sddm.enable = true;
    sessionPackages = [
      driftwmPackage
    ];
  };

  services.desktopManager.plasma6.enable = true;
  services.printing.enable = true;

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  security.polkit.enable = true;
  security.rtkit.enable = true;

  users.users.${userName} = {
    isNormalUser = true;
    description = "NixOS User";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  programs.firefox.enable = true;
  programs.zsh.enable = true;

  environment.systemPackages = [
    driftwmPackage
  ] ++ (with pkgs; [
    # Core command-line tools
    git
    fastfetch
    vim
    wget
    curl
    bubblewrap

    # Monitoring and search tools
    htop
    btop
    ripgrep
    fd
    tree
    unzip
    zip

    # Hardware, disk, and network diagnostics
    efibootmgr
    pciutils
    usbutils
    lshw
    dmidecode
    smartmontools
    nvme-cli
    lm_sensors
    inxi
    parted
    gptfdisk
    dosfstools
    exfat
    ntfs3g
    file
    lsof
    dig
    inetutils
    nmap

    # Desktop and Wayland session tools
    vesktop
    kitty
    foot
    fuzzel
    waybar
    mako
    wl-clipboard
    grim
    slurp
    brightnessctl
    xwayland-satellite
  ]);

  xdg.portal = {
    enable = true;
    wlr = {
      enable = true;
      settings.screencast = {
        chooser_type = "none";
        output_name = "eDP-1";
        max_fps = 60;
      };
    };

    extraPortals = with pkgs; [
      kdePackages.xdg-desktop-portal-kde
      xdg-desktop-portal-gtk
    ];

    config = {
      common.default = [ "gtk" ];

      kde = {
        default = [ "kde" "gtk" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "kde" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "kde" ];
        "org.freedesktop.impl.portal.RemoteDesktop" = [ "kde" ];
      };

      driftwm = {
        default = [ "wlr" "gtk" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
        "org.freedesktop.impl.portal.RemoteDesktop" = [ "wlr" ];
      };
    };
  };

  system.stateVersion = "26.05"; # Keep at initial install release.
}
