{ config, pkgs, inputs, ... }:
{
  # Make sure the nix daemon always runs
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;
  # Installs a version of nix, that dosen't need "experimental-features = nix-command flakes" in /etc/nix/nix.conf
  # services.nix-daemon.package = pkgs.nixFlakes;

  # if you use zsh (the default on new macOS installations),
  # you'll need to enable this so nix-darwin creates a zshrc sourcing needed environment changes
  programs.fish.enable = true;
  # bash is enabled by default
}
