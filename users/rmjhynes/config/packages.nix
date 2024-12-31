{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Terminals
    foot

    # CLI
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
    tree

    # Languages
    python314
    go
    terraform

    # Applications
    librewolf

    # Hyprland
    rofi-wayland
    waybar
    hyprpaper
  ];
}
