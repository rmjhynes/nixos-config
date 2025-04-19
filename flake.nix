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

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
    };

  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      dotfiles,
      ghostty,
      zen-browser,
      pre-commit-hooks,
      ...
    }:
    let
      systemIntel = "x86_64-linux";
      systemArm = "aarch64-linux";

      # Setup helper function to install and run pre-commit hooks
      # for all system architectures
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems =
        f:
        nixpkgs.lib.genAttrs supportedSystems (
          system:
          f {
            inherit system;
            pkgs = nixpkgs.legacyPackages.${system};
          }
        );

      pkgs = import nixpkgs {
        inherit systemIntel;
        inherit systemArm;
      };
      lib = nixpkgs.lib;
      specialArgs = {
        inherit dotfiles;
        inherit ghostty;
      };

      # Reusable home-manager configuration function meaning I don't
      # have to write this for every nixos host below
      mkHomeConfiguration =
        { dotfiles }:
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            inherit dotfiles;
          };
          home-manager.users.rmjhynes = {
            imports = [ ./users/rmjhynes/rmjhynes.nix ];
          };
        };

    in
    {
      # Pre-commit hooks config using git-hooks.nix
      checks = forAllSystems (
        { system, pkgs }:
        {
          pre-commit-check = pre-commit-hooks.lib.${system}.run {
            # Use the current directory as source for checking files
            src = ./.;
            # Define which hooks to enable
            hooks = {
              # Only using nix formatting
              nixfmt-rfc-style.enable = true;
            };
          };
        }
      );

      # devshell to install and run pre-commit hooks
      devShells = forAllSystems (
        { system, pkgs }:
        {
          default = pkgs.mkShell {
            inherit (self.checks.${system}.pre-commit-check) shellHook;
            buildInputs = self.checks.${system}.pre-commit-check.enabledPackages;
          };
        }
      );

      # Host machine configurations
      nixosConfigurations = {

        # Config for NixOS on a VM on M3 macbook pro
        vm = lib.nixosSystem {
          system = systemArm;
          modules = [
            {
              environment.systemPackages = [
                ghostty.packages.${systemArm}.default
                zen-browser.packages.${systemArm}.twilight
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
          system = systemIntel;
          modules = [
            # Laptop sepcific config
            ./hosts/dell-laptop/configuration.nix
            home-manager.nixosModules.home-manager
            (mkHomeConfiguration { dotfiles = dotfiles; })
          ];
        };

        # Config for NixOS on EC2
        ec2 = lib.nixosSystem {
          system = systemIntel;
          modules = [
            # EC2 sepcific config
            ./hosts/ec2/configuration.nix
            home-manager.nixosModules.home-manager
            (mkHomeConfiguration { dotfiles = dotfiles; })
          ];
        };

        # Config for NixOS on Beelink for Homelab
        beelink-s12 = lib.nixosSystem {
          system = systemIntel;
          modules = [
            {
              environment.systemPackages = [
                ghostty.packages.${systemIntel}.default
                zen-browser.packages.${systemIntel}.twilight
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
