{
  description = "A simple NixOs flake";
  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-23.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixos-hardware, home-manager, ... }: {

    # the nixos-vm
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/nixos-vm/configuration.nix
        home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.gaerfield = import ./hosts/nixos-vm/home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
            # home-manager.extraSpecialArgs = inputs;
        }
      ];
    };

    nixosConfigurations."bmscs-21337" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/work/configuration.nix
	
	# actually its latitude 5521 ... but hej, YOLO
	# should enable gpu acceleration and power-management
	nixos-hardware.nixosModules.dell-latitude-5520

        home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.blaschke = import ./hosts/work/home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
            # home-manager.extraSpecialArgs = inputs;
        }
      ];
    };
  };
}
