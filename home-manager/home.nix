# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];


  home = {
    sessionVariables = {
      EDITOR = "nvim";
    };
  };


  home.packages = with pkgs; [
    sops
    kubectl
    fishPlugins.fzf-fish
    fzf

    fishPlugins.bass
    fishPlugins.hydro
    #fishPlugins.grc
    grc
    jetbrains.goland
    jetbrains.datagrip
    wofi
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  programs.git.userEmail = "me@jackg.se";
  programs.git.userName = "Jack Gardner";


  # Add stuff for your user as you see fit:

  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
#      target = "sway-session.target";
    };

    settings = {

       Main = {
	 modules-left = with config; [
	];
       };
    };
  };
  

  services.swayidle.enable = true;
  programs.neovim.enable = true;
  programs.fish = {
    enable = true;
    shellAliases = {
        drogo = "cd ~/go/src/github.com/lakahq/drogo";
        nix-config = "cd ~/Development/nixos-config";
        ls = "exa";
    };
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    plugins = [
      { name = "bass"; src = pkgs.fishPlugins.bass.src; }
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      { name = "hydro"; src = pkgs.fishPlugins.hydro.src; }
      { name = "fzf"; src = pkgs.fishPlugins.fzf-fish.src; }
      {
        name = "fish-nvm";
        src = pkgs.fetchFromGitHub {
            owner = "FabioAntunes";
            repo = "fish-nvm";
            rev = "1.4.4";
            sha256 = "sha256-wB1p4MWKeNdfMaJlUwkG+bJmmEMRK+ntykgkSuDf6wE=";
        };
      }
      {
        name = "nix-env";
	    src = pkgs.fetchFromGitHub {
          owner = "lilyball";
          repo = "nix-env.fish";
          rev = "00c6cc762427efe08ac0bd0d1b1d12048d3ca727";
          sha256 = "1hrl22dd0aaszdanhvddvqz3aq40jp9zi2zn0v1hjnf7fx4bgpma";
      	};
      }
    ];
  };
  programs.tmate.enable = true;
  programs.firefox.enable = true;
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    clock24 = true;
    terminal = "screen-256color";
    prefix = "C-a";
    mouse = true;

    historyLimit = 10000;
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      gruvbox
    ];
    extraConfig = ''
      set -sg escape-time 0 # makes vim esc usable

      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
    '';
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "GitHub";
      italic-text = "always";
    };
  };

  # programs.steam.enable = true;
  # Enable home-manager and git


  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}
