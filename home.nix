{ config, pkgs, dotfiles, ... }:

{
  home.username = "rmjhynes";
  home.homeDirectory = "/home/rmjhynes";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  home.file."test.txt".text = "This is a test...";

  home.file = {
    ".aliases" = {
      source = dotfiles + "/.aliases";
    };
  };

  home.packages = with pkgs; [
   ripgrep
  ];
}

