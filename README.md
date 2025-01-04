# NixOS Configurations
After researching different Linux distributions and trying out Arch as my first, I came across NixOS. NixOS allows me to declaratively configure my different Linux hosts and pin dependency versions using a Flake. This means I can give my config to anyone and they would be able to reproduce the exact same system. This repo is definitely not the 'perfect' way to organise and configure everything but has been a great learning experience and I will continue to update and improve as I go.

## Installation
1) Firstly, you need to install NixOS on your machine. The ISOs can be found on the [official NixOS download page](https://nixos.org/download/).
2) Clone this repository and add new configurations under `hosts/<machine-name>`.
3) Add a new host machine configuration in `flake.nix` and reference the configuration to use.
4) Run `sudo nixos-rebuild switch --flake <path/to/flake.nix>#<host-name-in-flake.nix>` to rebuild the machine as per the config.

## Hosts
This repo contains the following hosts:
- vm: A virtual machine running on my M3 Macbook Pro.
- dell-laptop: A really old laptop that I first tried NixOS on.
- ec2: (WIP) An ec2 instance where I deploy my NixOS config via a pipeline (cos why not?).
