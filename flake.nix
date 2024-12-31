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
      flake = true;
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

    # Reusable home-manager configuration function meaning I don't
    # have to configure this for every nixos host config
    mkHomeConfiguration = { dotfiles }: {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = {
        inherit dotfiles;
      };
      home-manager.users.rmjhynes = {
        imports = [ ./users/rmjhynes/rmjhynes.nix ];
      };
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
	  # VM sepcific config
	  ./hosts/vm/configuration.nix
	  home-manager.nixosModules.home-manager
	  (mkHomeConfiguration {
	    dotfiles = dotfiles;
	  })
	];
      };

      # Config for ancient Dell laptop
      dell-laptop = lib.nixosSystem {
        inherit system;
	modules = [
	  {
	    environment.systemPackages = [
	      ghostty.packages.x86_64-linux.default
	    ];
	  }
          # Laptop sepcific config
	  ./hosts/vm/configuration.nix
	  home-manager.nixosModules.home-manager
	  (mkHomeConfiguration {
	    dotfiles = dotfiles;
	  })
	];
      };
    };
  };
}
