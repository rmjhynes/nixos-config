{
  description = "My config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dotfiles = {
      url = "git+https://github.com/rmjhynes/dotfiles.git";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, dotfiles, ... }:
  let 
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
    lib = nixpkgs.lib;
    specialArgs = {
      inherit dotfiles;
    };
  in {
    nixosConfigurations = {
      rmjhynes = lib.nixosSystem {
        inherit system;
	modules = [
	  ./configuration.nix
	  home-manager.nixosModules.home-manager {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.extraSpecialArgs = {
	      inherit dotfiles;
	    };
	    home-manager.users.rmjhynes = {
	      imports = [ ./home.nix ];
	    };
	  }
	];
      };
      bob = lib.nixosSystem {
        inherit system;
	modules = [
	  ./configuration.nix
	  home-manager.nixosModules.home-manager {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.users.bob = {
	      imports = [ ./bob.nix ];
	    };
	  }
	];
      };
    };
  };
  

#  outputs = { self, nixpkgs, home-manager, dotfiles, ... }@inputs: {
#    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
#      system = "x86_64-linux";
#      modules = [
#        ./configuration.nix
#	home-manager.nixosModules.home-manager
#	{
#	  home-manager.useGlobalPkgs = true;
#	  home-manager.useUserPackages = true;
#	  home-manager.users.rmjhynes = import ./home.nix;
#	}
#      ];
#    };
#  };
}
