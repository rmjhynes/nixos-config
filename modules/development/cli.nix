{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
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
