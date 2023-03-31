{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-22.11-darwin";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";


    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # TODO: Add any other flake you might need
    hardware.url = "github:nixos/nixos-hardware";

    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    nix-colors.url = "github:misterio77/nix-colors";

    hyprland.url = "github:hyprwm/hyprland";
    hyprwm-contrib.url = "github:hyprwm/contrib";

  };

  outputs = { nixpkgs, nixpkgs-darwin, nixpkgs-master, home-manager, hyprland, darwin, ... }@inputs: {

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      # FIXME replace with your hostname
      woundwort = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs hyprland; }; # Pass flake inputs to our config
        # > Our main nixos configuration file <
        modules = [ 
          ./hosts/woundwort/default.nix
          ./modules/fonts.nix
          hyprland.nixosModules.default 
          inputs.home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = [ hyprland.overlays.default ];
            networking.hostName = "woundwort";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.jack = {
              imports = [
                ./common/default.nix 
                ./hosts/woundwort/home.nix
              ];
            };
          }
      	];
      };
    };

    darwinConfigurations = {
        campion = darwin.lib.darwinSystem {
            system = "aarch64-darwin";
            modules = [
                ./hosts/campion/default.nix
                home-manager.darwinModules.home-manager
                {
                    networking.hostName = "campion";
                    nixpkgs.config.allowUnfree = true;
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.extraSpecialArgs = { inherit inputs; };
                    home-manager.users.jack = {
                      imports = [
                        ./common/default.nix 
                        ./hosts/campion/home.nix
                      ];
                    };
                }
            ];
            inputs = { inherit darwin home-manager; };
        };
    };
  };
}
