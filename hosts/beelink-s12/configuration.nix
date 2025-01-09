
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Import the configuration shared between all hosts
      ../common/configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #networking.hostName = "homelab"; # Define your hostname.

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [  22 ];
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "yes";
    };
  }; 

  services.k3s = {
    enable = true;
    role = "server";
    extraFlags = [
      "--docker" # Use cri-dockerd instead of containerd
      "--write-kubeconfig-mode 644"  # Makes it readable by all users (sudo not necessary to run k3s commands)
    ];
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    22 # ssh
    6443 # k3s: required so that pods can reach the API server (running on port 6443 by default)
  ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

}
