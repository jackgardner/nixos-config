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

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
        monitor=,preferred,auto,1

        
        exec-once = hyprpaper
        input {
            kb_layout = gb
            kb_options = "ctrl:nocaps, shift:both_capslock"

            follow_mouse = 1

            touchpad {
                natural_scroll = no
                tap-to-click = false
            }
        }

        general {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more

            gaps_in = 3
            gaps_out = 20
            border_size = 2
            col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
            col.inactive_border = rgba(595959aa)

            layout = dwindle
        }

        decoration {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more

            rounding = 2
            blur = yes
            blur_size = 3
            blur_passes = 1
            blur_new_optimizations = on

            drop_shadow = no
            shadow_range = 4
            shadow_render_power = 3
            col.shadow = rgba(1a1a1aee)
        }

        animations {
            enabled = yes

            # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

            bezier = myBezier, 0.05, 0.9, 0.1, 1.05

            animation = windows, 1, 7, myBezier
            animation = windowsOut, 1, 7, default, popin 80%
            animation = border, 1, 10, default
            animation = borderangle, 1, 8, default
            animation = fade, 1, 7, default
            animation = workspaces, 1, 6, default
        }

        dwindle {
            # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
            pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
            preserve_split = yes # you probably want this
        }

        master {
            # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
            new_is_master = true
        }

        gestures {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more
            workspace_swipe = off
        }

        # Example per-device config
        # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
        device:epic mouse V1 {
            sensitivity = -0.5
        }

        # Example windowrule v1
        # windowrule = float, ^(kitty)$
        # Example windowrule v2
        # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
        # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more


        # See https://wiki.hyprland.org/Configuring/Keywords/ for more
        $mainMod = SUPER

        # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
        bind = $mainMod, W, exec, kitty
        bind = $mainMod, Q, killactive, 
        bind = $mainMod, M, exit, 
        bind = $mainMod, E, exec, firefox 
        bind = $mainMod, V, togglefloating, 
        bind = $mainMod, R, exec, wofi --show drun
        bind = $mainMod, P, pseudo, # dwindle
        bind = $mainMod, J, togglesplit, # dwindle
        bind = $mainMod, Z, fullscreen
        bind = $mainMod, F, workspaceopt, allfloat
        bind = $mainMod, C, centerwindow

        # Move focus with mainMod + arrow keys
        bind = $mainMod, left, movefocus, l
        bind = $mainMod, right, movefocus, r
        bind = $mainMod, up, movefocus, u
        bind = $mainMod, down, movefocus, d

        # Switch workspaces with mainMod + [0-9]
        bind = $mainMod, 1, workspace, 1
        bind = $mainMod, 2, workspace, 2
        bind = $mainMod, 3, workspace, 3
        bind = $mainMod, 4, workspace, 4
        bind = $mainMod, 5, workspace, 5
        bind = $mainMod, 6, workspace, 6
        bind = $mainMod, 7, workspace, 7
        bind = $mainMod, 8, workspace, 8
        bind = $mainMod, 9, workspace, 9
        bind = $mainMod, 0, workspace, 10

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        bind = $mainMod SHIFT, 1, movetoworkspace, 1
        bind = $mainMod SHIFT, 2, movetoworkspace, 2
        bind = $mainMod SHIFT, 3, movetoworkspace, 3
        bind = $mainMod SHIFT, 4, movetoworkspace, 4
        bind = $mainMod SHIFT, 5, movetoworkspace, 5
        bind = $mainMod SHIFT, 6, movetoworkspace, 6
        bind = $mainMod SHIFT, 7, movetoworkspace, 7
        bind = $mainMod SHIFT, 8, movetoworkspace, 8
        bind = $mainMod SHIFT, 9, movetoworkspace, 9
        bind = $mainMod SHIFT, 0, movetoworkspace, 10

        # Scroll through existing workspaces with mainMod + scroll
        bind = $mainMod, mouse_down, workspace, e+1
        bind = $mainMod, mouse_up, workspace, e-1

        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = $mainMod, mouse:272, movewindow
        bindm = $mainMod, mouse:273, resizewindow

    '';
  };

  home.packages = with pkgs; [
    kitty
    vscode
    jetbrains.goland
    jetbrains.datagrip
    wofi
    waybar
    slack
    hyprpaper
  ];

  # Add stuff for your user as you see fit:

  programs.waybar = {
    enable = true;
    systemd = {
    	enable = true;
	    target = "graphical-session.target";
    };
    style = ''
    @define-color critical #ff0000; /* critical color */
@define-color warning #f3f809;  /* warning color */
@define-color fgcolor #ffffff;  /* foreground color */
@define-color bgcolor #303030;  /* background color */
@define-color bgcolor #222436;  /* background color */
@define-color alert   #df3320;

@define-color accent1 #ff7a93;
@define-color accent2 #b9f27c;
@define-color accent3 #ff9e64;
@define-color accent4 #bb9af7;
@define-color accent5 #7da6ff;
@define-color accent6 #0db9d7;

* {
    /* `otf-font-awesome` is required to be installed for icons */
    border: none;
    font-family: "monospace, Font Awesome 5";
    /* Recommended font sizes: 720p: ~14px, 1080p: ~18px */
    font-size: 14px;
}

window#waybar {

    background-color: rgba(34, 36, 54, 0.6);
    /* border-bottom: 0px solid rgba(100, 114, 125, 0.5); */
    color: #ffffff;
    transition-property: background-color;
    transition-duration: .5s;
    border-radius: 4px;
}

window#waybar.hidden {
    opacity: 0.2;
}

#workspaces button {
    padding: 0px;
    margin: 4px 0 6px 0;
    background-color: transparent;
    color: @accent1;
    min-width: 36px;
}

#workspaces button.active {
    padding: 0 0 0 0;
    margin: 4px 0 6px 0;
    background-color: transparent;
    color: #ffffff;
    min-width: 36px;
}

#workspaces button:hover {
    background: rgba(0, 0, 0, 0.2);
}

#workspaces button.focused {
    background-color: #bbccdd;
    color: #323232;
}

#workspaces button.urgent {
    color: red;
}

#mode {
    background-color: #64727D;
    border-bottom: 1px solid #ffffff;
}

#clock,
#battery,
#cpu,
#memory,
#temperature,
#backlight,
#network,
#pulseaudio,
#custom-media,
#tray,
#mode,
#idle_inhibitor,
#custom-power,
#custom-pacman,
#language {
    padding: 0px 3px;
    margin: 4px 3px 5px 3px;
    color: @fgcolor;
    background-color:transparent;
}

#window,
#workspaces {
    margin: 0 4px;
}

/* If workspaces is the leftmost module, omit left margin */
.modules-left > widget:first-child > #workspaces {
    margin-left: 0;
}

/* If workspaces is the rightmost module, omit right margin */
.modules-right > widget:last-child > #workspaces {
    margin-right: 0;
}

#clock {
    color: #90ee90;
}

#battery {
    color: @accent5;
}

@keyframes blink {
    to {
        background-color: #ffffff;
        color: #333333;
    }
}

#battery.critical:not(.charging) {
    background-color: @critical;
    color: @white;
}

label:focus {
    background-color: #000000;
}

#cpu {
    color: @accent1;
}

#memory {
    color: #86e2d5;
}

#backlight {
    color: @accent2;
}

#network {
    color: @accent3;
}

#network.disconnected {
    color: @alert;
}

#pulseaudio {
    color: @accent4;
}

#pulseaudio.muted {
    color: #a0a0a0;
}

#custom-power {
    color: @accent6;
}

#custom-waylandvsxorg {
    color: @accent5;
}

#custom-pacman {
    color: @accent2;
}

#custom-media {
    background-color: #66cc99;
    color: #2a5c45;
    min-width: 100px;
}

#custom-media.custom-spotify {
    background-color: #66cc99;
}

#custom-media.custom-vlc {
    background-color: #ffa000;
}

#temperature {
    color: @accent6;
}

#temperature.critical {
    background-color: @critical;
}

#tray {

}

#idle_inhibitor {
    background-color: #343434;
    border-radius: 4px;
}

#mpd {
    color: #d1e231;
}

#custom-language {
    color: @accent5;
    min-width: 16px;
}

#custom-separator {
    color: #606060;
    margin: 0 1px;
    padding-bottom: 5px;
}

#custom-wmname {
    min-width: 36px;
    font-size: 15px;
}

#custom-recorder,
#custom-audiorec {
    color: #c71585;
}


'';
    settings = [{
      modules-left = ["wlr/workspaces"];
      modules-center = ["hyprland/window"];
      modules-right = [
        "pulseaudio"
        "network"
        "cpu"
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
        format = "{icon}&#8239;{capacity}%";
        format-alt = "{time} {icon}";
        format-charging = "{capacity}% ";
        format-icons = [ "" "" "" "" "" ];
        format-plugged = "{capacity}% ";
        states = {
          critical = 15;
          warning = 30;
        };
      };
      "wlr/workspaces" = {
        format = "{icon}";
        
        # format-icons = {

            # "1" =  "";
            # "2"="";
            # "3"="";
            # "4"="";
            # "5"="";
            # "6"="";
            # "7"="";
            # "8"="";
            # "9"="";
            # "urgent"="";
            # "focused"="";
            # "default"="";
        # };
      };
      clock = {
        format-alt = "{:%Y-%m-%d}";
        tooltip-format = "{:%Y-%m-%d | %H:%M}";
      };
      cpu = {
        format = "&#8239;{usage}%";
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
  
  programs.firefox.enable = true;
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}
