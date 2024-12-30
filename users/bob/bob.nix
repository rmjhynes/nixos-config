{ config, pkgs, ... }:

{
  home.username = "bob";
  home.homeDirectory = "/home/bob";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  home.file."test.txt".text = "test.txt";

  home.packages = with pkgs; [
   ripgrep
  ];
}

