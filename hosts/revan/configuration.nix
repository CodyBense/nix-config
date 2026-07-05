# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  username,
  inputs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/desktop
    ../../modules/development
    ../../modules/fabrication
    ../../modules/shares
  ];

  # kernal
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Define your hostname.
  networking.hostName = "revan";

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.fwupd.enable = true;

  networking.firewall.allowedTCPPorts = [ 8384 ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cody = {
    isNormalUser = true;
    description = "cody";
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
      "audio"
    ];
    packages = with pkgs; [
      #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Allow nix flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    # Required so non-root users are allowed to use the above substituter/keys.
    # Use @wheel for all sudo users, or list your username explicitly.
    trusted-users = [
      "root"
      "@wheel"
    ];
  };

  # for helium browser install
  security.chromiumSuidSandbox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    arduino-cli
    bat
    btop
    cifs-utils
    coreutils
    kdePackages.dolphin
    direnv
    fastfetch
    firefox
    freecad-wayland
    fzf
    gh
    gimp
    git
    gnupg
    grimblast
    gum
    inputs.helium.packages.${system}.default
    # helium-browser
    imv
    jq
    jqp
    kitty
    lazygit
    libreoffice
    localsend
    neovim
    pinentry-curses
    proton-vpn
    rofi
    rsync
    solaar
    spotify
    sioyek
    swaynotificationcenter
    starship
    syncthing
    television
    tree
    unzip
    vlc
    viber
    waybar
    wf-recorder
    wget
    wireguard-tools
    wl-clipboard
    yazi
    zathura
    zathuraPkgs.zathura_pdf_mupdf
    zellij
    zoxide
  ];

  services.udev.extraRules = ''
    # This rule was added by Solaar.
    #
    # Allows non-root users to have raw access to Logitech devices.
    # Allowing users to write to the device is potentially dangerous
    # because they could perform firmware updates.

    ACTION == "remove", GOTO="solaar_end"
    SUBSYSTEM != "hidraw", GOTO="solaar_end"

    # USB-connected Logitech receivers and devices
    ATTRS{idVendor}=="046d", GOTO="solaar_apply"

    # Lenovo nano receiver
    ATTRS{idVendor}=="17ef", ATTRS{idProduct}=="6042", GOTO="solaar_apply"

    # Bluetooth-connected Logitech devices
    KERNELS == "0005:046D:*", GOTO="solaar_apply"

    GOTO="solaar_end"

    LABEL="solaar_apply"

    # Allow any seated user to access the receiver.
    # uaccess: modern ACL-enabled udev
    TAG+="uaccess"

    # Grant members of the "plugdev" group access to receiver (useful for SSH users)
    #MODE="0660", GROUP="plugdev"

    LABEL="solaar_end"
    # vim: ft=udevrules
  '';

  # nh
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 5";
    flake = "/home/${username}/nix-config";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
