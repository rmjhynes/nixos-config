# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # Import the configuration shared between all hosts
    ../common/configuration.nix
  ];

  # Using GRUB bootloader over system-d as it looks nicer
  boot.loader = {
    efi = {
      canTouchEfiVariables = true; # Allow managing EFI vars
      efiSysMountPoint = "/boot"; # Where EFI system partition is mounted
    };
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev"; # Required for UEFI install
      configurationLimit = 5;
    };
  };

  environment.variables = {
    KUBECONFIG = "/etc/rancher/k3s/k3s.yaml"; # Tells k8s tools which config file to use when interacting with the cluster
  };

  # Enables support for bluetooth
  hardware.bluetooth.enable = true;
  # Powers up the default bluetooth controller on boot
  hardware.bluetooth.powerOnBoot = true;

  #networking.hostName = "homelab"; # Define your hostname.

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [ 22 ];
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
      "--write-kubeconfig-mode 644" # Makes kubeconfig file readable by all users (sudo not necessary to run k3s commands)
      "--node-name master-node"
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

  # Setup /etc/resolv.conf file to configure DNS resolution to point at the
  # kube-dns service in k3s
  environment.etc."resolv.conf".text = ''
    nameserver 10.43.0.10
    options edns0
  '';

}
