{ config, pkgs, dotfiles, ... }:

{
  home.username = "rmjhynes";
  home.homeDirectory = "/home/rmjhynes";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  # Importing dotfiles from dotfiles github repo.
  home.file = {

    "/.config/nvim" = {
      source = dotfiles + "/nvim";
      recursive = true;
    };

    ".zshrc".source = dotfiles + "/.zshrc";
    ".p10k.zsh".source = dotfiles + "/.p10k.zsh";
    ".aliases".source = dotfiles + "/.aliases";
    ".vimrc".source = dotfiles + "/.vimrc";
    ".tmux.conf".source = dotfiles + "/.tmux.conf";

  };

  programs.git = {
    enable = true;
    userName = "Ryan Hynes";
    userEmail= "131348960+rmjhynes@users.noreply.github.com";
    extraConfig = {
      init.defaultbranch = "main";
    };
  };

  home.packages = with pkgs; [
   ripgrep
  ];
}

