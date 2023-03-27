{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-22.11-darwin";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";


    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # TODO: Add any other flake you might need
    hardware.url = "github:nixos/nixos-hardware";

    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    nix-colors.url = "github:misterio77/nix-colors";

    hyprland.url = "github:hyprwm/hyprland/v0.23.0beta";
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
	  ./nixos/configuration.nix 
	  hyprland.nixosModules.default 
	  inputs.home-manager.nixosModules.home-manager
          {
	    networking.hostName = "woundwort";
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.extraSpecialArgs = { inherit inputs; };
	    home-manager.users.jack = import ./home-manager/home.nix;
	  }

	];
      };
    };

    darwinConfigurations = {
        campion = darwin.lib.darwinSystem {
            system = "aarch64-darwin";
            modules = [
                home-manager.darwinModules.home-manager
                {
                    #nixpkgs.overlays = overlays;
                    #system.darwinLabel = "${config.system.darwinLabel}@${rev}";
                    networking.hostName = "campion";
                    nixpkgs.config.allowUnfree = true;
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.extraSpecialArgs = { inherit inputs; };
                    home-manager.users.jack = import ./home-manager/home.nix;
                }

                ./hosts/campion/default.nix

            ];
            inputs = { inherit darwin home-manager; };
        };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'

    };
}
