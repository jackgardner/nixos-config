# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    inputs.hyprland.homeManagerModules.default
    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  home.packages = with pkgs; [
    kitty
    vscode
    jetbrains.goland
    jetbrains.datagrip
    wofi
    waybar
    slack
  ];

  # Add stuff for your user as you see fit:
  programs.firefox.enable = true;

  programs.waybar = {
    enable = true;
    systemd = {
    	enable = true;
	    target = "graphical-session.target";
    };
    settings = [{
      modules-left = ["wlr/workspaces"];
      modules-center = ["hyprland/window"];
      modules-right = [
        "pulseaudio"
        "network"
        "cpu"
        "memory"
        "battery"
        "clock"
        "tray"
      ];
      network = {
        interval = 1;
        format-alt = "{ifname}: {ipaddr}/{cidr}";
        format-disconnected = "Disconnected ⚠";
        format-ethernet = "{ifname}: {ipaddr}/{cidr}   up: {bandwidthUpBits} down: {bandwidthDownBits}";
        format-linked = "{ifname} (No IP) ";
        format-wifi = "{essid} ({signalStrength}%) ";
      };
      battery = {
        format = "{capacity}% {icon}";
        format-alt = "{time} {icon}";
        format-charging = "{capacity}% ";
        format-icons = [ "" "" "" "" "" ];
        format-plugged = "{capacity}% ";
        states = {
          critical = 15;
          warning = 30;
        };
      };
      clock = {
        format-alt = "{:%Y-%m-%d}";
        tooltip-format = "{:%Y-%m-%d | %H:%M}";
      };
      cpu = {
        format = "{usage}% ";
        tooltip = false;
      };
      # memory = {
        # format = "{capacity}% {icon}";
        # format-alt = "{time} {icon}";
        # format-charging = "{capacity}% ";
        # format-icons = [ "" "" "" "" "" ];
        # format-plugged = "{capacity}% ";
        # states = {
        #   critical = 15;
        #   warning = 30;
        # };
      # };  
    }];
  };
  

  systemd.user.services.waybar = {
    Install.WantedBy = [ "graphical-session-pre.target" ];
  };
  services.swayidle.enable = true; 
  programs.kitty = {
    enable = true;
    theme = "Gruvbox Material Dark Hard";

  };
  
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}
