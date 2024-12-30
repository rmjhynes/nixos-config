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
    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
  };

  outputs = { self, nixpkgs, home-manager, dotfiles, ghostty, ... }:
  let 
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
    lib = nixpkgs.lib;
    specialArgs = {
      inherit dotfiles;
      inherit ghostty;
    };
  in {
    nixosConfigurations = {
      # Config for Nix on a VM
      vm = lib.nixosSystem {
        inherit system;
	modules = [
	  {
	    environment.systemPackages = [
	      ghostty.packages.aarch64-linux.default
	    ];
	  }
	  ./hosts/vm/configuration.nix
	  home-manager.nixosModules.home-manager {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.extraSpecialArgs = {
	      inherit dotfiles;
	    };
	    home-manager.users.rmjhynes = {
	      imports = [ ./users/rmjhynes/rmjhynes.nix ];
	    };
	  }
	];
      };
      # Config for ancient Dell laptop
      dell-laptop = lib.nixosSystem {
        inherit system;
	modules = [
	  {
	    environment.systemPackages = [
	      ghostty.packages.aarch64-linux.default
	    ];
	  }
	  ./hosts/dell-laptop/configuration.nix
	  home-manager.nixosModules.home-manager {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.extraSpecialArgs = {
	      inherit dotfiles;
	    };
	    home-manager.users.rmjhynes = {
	      imports = [ ./users/rmjhynes/rmjhynes.nix ];
	    };
	  }
	];
      };
      bob = lib.nixosSystem {
        inherit system;
	modules = [
	  ./hosts/vm/configuration.nix
	  home-manager.nixosModules.home-manager {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.users.bob = {
	      imports = [ ./users/bob/bob.nix ];
	    };
	  }
	];
      };
    };
  };
}
