{ config, pkgs, ... }:

{
  home.username = "rmjhynes";
  home.homeDirectory = "/home/rmjhynes";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;


  home.packages = with pkgs; [
   ripgrep
  ];
}

