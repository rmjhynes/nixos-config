{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    awscli2
    vim
    neovim
    tmux
    bat
    fzf
    htop
    thefuck
    tlrc
    neofetch
  ];
}
