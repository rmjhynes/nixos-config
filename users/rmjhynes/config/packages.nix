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
    k9s
    jq

    # Languages
    python314
    go
    terraform

    # Infra
    k3s
    argocd
    kubernetes-helm

    # Applications
    firefox
    librewolf

    # Hyprland
    rofi-wayland
    waybar
    hyprpaper
  ];
}
