{ config, pkgs, inputs, ... }:
{
  # Make sure the nix daemon always runs
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;
  # Installs a version of nix, that dosen't need "experimental-features = nix-command flakes" in /etc/nix/nix.conf
  # services.nix-daemon.package = pkgs.nixFlakes;

  # if you use zsh (the default on new macOS installations),
  # you'll need to enable this so nix-darwin creates a zshrc sourcing needed environment changes
  # bash is enabled by default

  homebrew = {                            # Declare Homebrew using Nix-Darwin
    enable = true;
    onActivation = {
      autoUpdate = false;                 # Auto update packages
      upgrade = false;
      # cleanup = "zap";                    # Uninstall not listed packages and casks
    };
    brews = [
      "wireguard-tools"
    ];
    casks = [
      "plex-media-player"
    ];
  };

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
