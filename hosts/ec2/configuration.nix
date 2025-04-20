# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    # Import the configuration shared between all hosts
    ../common/configuration.nix
  ];

  # Using GRUB bootloader over system-d as it looks nicer
  boot.loader = {
    grub = {
      enable = true;
      device = "/dev/xvda";
      configurationLimit = 5;
    };
  };
}
