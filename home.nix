{ config, pkgs, ... }:

{
  home.username = "rmjhynes";
  home.homeDirectory = "/home/rmjhynes";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  home.file."test.txt".text = "test.txt";

  home.packages = with pkgs; [
   ripgrep
  ];
}

