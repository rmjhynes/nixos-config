# NixOS Configurations
After researching different Linux distributions and trying out Arch as my first, I came across NixOS. NixOS allows me to declaratively *(like Terraform)* configure my different Linux hosts and pin dependency versions using a Flake. This means I can give my config to anyone and they would be able to reproduce the exact same system. This repo is definitely not the *perfect* way to organise and configure everything but has been a great learning experience and I will continue to update and improve as I go.

## Installation
1) Firstly, you need to install NixOS on your machine. The ISOs can be found on the [official NixOS download page](https://nixos.org/download/).
2) Clone this repository and add configurations for each new host machine under `hosts/<machine-name>`.
3) Add a new host machine configuration in `flake.nix` and reference the configuration to use.
4) Run `sudo nixos-rebuild switch --flake <path/to/flake/directory>#<host-name>` to rebuild the machine as per its config.

## Hosts
This repo contains the following hosts:
- vm: A virtual machine running on my M3 Macbook Pro.
- dell-laptop: A really old laptop that I first tried NixOS on.
- ec2: (WIP) An ec2 instance where I deploy my NixOS config via a pipeline *(cos why not?)*.

## Nix Home Manager
Home Manager is a system for managing a user environment using the Nix package manager. Software packages and modules installed by NixOS are global to the entire system. Packages and modules installed via Home Manager will be linked to the respective user's home directory, therefore allowing you to manage each individual user's environment on the host machine. Since realistically I am the only person who is ever going to touch these Nix configs, I only have one user and use Home Manager to install my dotfiles in my own user directory. This means I don't have to manually clone my dotfiles repo and set everything up.
