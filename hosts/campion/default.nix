{ config, pkgs, inputs, ... }:
{
  # Make sure the nix daemon always runs
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;
  # Installs a version of nix, that dosen't need "experimental-features = nix-command flakes" in /etc/nix/nix.conf
  # services.nix-daemon.package = pkgs.nixFlakes;

  system.defaults.dock.autohide = true;
  system.defaults.dock.mru-spaces = false;
  system.defaults.dock.orientation = "left";
  system.defaults.dock.showhidden = true;


  users.users.jack.shell = pkgs.fish;
  # if you use zsh (the default on new macOS installations),
  # you'll need to enable this so nix-darwin creates a zshrc sourcing needed environment changes
  # bash is enabled by default
  homebrew = {                            # Declare Homebrew using Nix-Darwin
    enable = true;
    onActivation = {
      autoUpdate = false;                 # Auto update packages
      upgrade = false;
      cleanup = "zap";                    # Uninstall not listed packages and casks
    };
    brews = [
      "wireguard-tools"
      "yq"
      "jq"
      "fzf"
      "lazydocker"
      "lazygit"

      "jsonnet"
      "terraform"
    ];
    casks = [

    ];
  };

  environment.systemPackages = with pkgs; [
    exa
    gnused
    gawk
  ];

  programs.fish.enable = true;
  environment.shells = with pkgs; [ bashInteractive zsh fish ];




  fonts = {                               # Fonts
    fontDir.enable = true;
    fonts = with pkgs; [
      source-code-pro
      font-awesome
      (nerdfonts.override {
        fonts = [
          "FiraCode"
        ];
      })
    ];
  };
}
