{
  description = "My NixOS configuration for multiple machines.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Import my dotfiles from github
    dotfiles = {
      url = "git+https://github.com/rmjhynes/dotfiles.git";
      flake = false;
    };

    # Import Ghostty flake from their repo until it is ready
    # as a Nix package
    ghostty = {
      url = "github:ghostty-org/ghostty";
      flake = true;
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
    };

  };

  outputs = { self, nixpkgs, home-manager, dotfiles, ghostty, zen-browser, ... }:
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
    # have to write this for every nixos host below
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
    # Host machine configurations
    nixosConfigurations = {

      # Config for NixOS on a VM on M3 macbook pro
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
          (mkHomeConfiguration { dotfiles = dotfiles; })
        ];
      };

      # Config for NixOS on ancient Dell laptop
      dell-laptop = lib.nixosSystem {
        inherit system;
        modules = [
          # Laptop sepcific config
          ./hosts/dell-laptop/configuration.nix
          home-manager.nixosModules.home-manager
          (mkHomeConfiguration { dotfiles = dotfiles; })
        ];
      };

      # Config for NixOS on EC2
      ec2 = lib.nixosSystem {
        inherit system;
        modules = [
          # EC2 sepcific config
          ./hosts/ec2/configuration.nix
          home-manager.nixosModules.home-manager
          (mkHomeConfiguration { dotfiles = dotfiles; })
        ];
      };

      # Config for NixOS on Beelink for Homelab
      beelink-s12 = lib.nixosSystem {
        inherit system;
        modules = [
          {
            environment.systemPackages = [
              ghostty.packages.${system}.default
              zen-browser.packages.${system}.twilight
            ];
          }
          # Homelab sepcific config
          ./hosts/beelink-s12/configuration.nix
          home-manager.nixosModules.home-manager
          (mkHomeConfiguration { dotfiles = dotfiles; })
        ];
      };

    };
  };
}
