{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    neovim
    tmux
    zsh
    bat
    fzf
    htop
    thefuck
    tlrc
    neofetch
  ];
}
