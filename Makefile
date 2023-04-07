darwin:
	nix --extra-experimental-features "nix-command flakes" build .#darwinConfigurations.campion.system
	./result/sw/bin/darwin-rebuild switch --flake .

woundwort:
	sudo nixos-rebuild switch --flake .#woundwort --impure