{ config, pkgs, dotfiles, ... }:

{
  imports = [
    ./config/hyprland.nix
    ./config/packages.nix
  ];

  home.username = "rmjhynes";
  home.homeDirectory = "/home/rmjhynes";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  # Importing dotfiles from my dotfiles github repo.
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
    ".config/kitty/kitty.conf".source = dotfiles + "/kitty.conf";
    ".config/ghostty/config".source = dotfiles + "/ghostty.conf";
    ".config/htop/htoprc".source = dotfiles + "/htoprc";
    "nixos_install.sh".source = dotfiles + "/scripts/nixos_install.sh";

    # Set wallpaper with hyprpaper
    ".config/hypr/hyprpaper.conf" = {
      text = ''
        preload = /home/rmjhynes/repos/nixos-config/hosts/common/nix-wallpaper.png
        wallpaper = , /home/rmjhynes/repos/nixos-config/hosts/common/nix-wallpaper.png
      '';
    };

    # Set waybar config
    ".config/waybar/config" = {
      text = ''
        {
          "layer": "top",
          "modules-center": ["clock"],
          "modules-right": ["memory", "network", "battery"],
          "modules-left": ["hyprland/workspaces"],

          "hyprland/workspaces": {
            "format": "{name}",
            "all-outputs": true,
            "persistent-workspaces": {
              "*": 10 // 10 workspaces shown in waybar by default on every monitor
            }
          },

          "clock": {
            "format": "{:%H:%M:%S %d-%m-%Y}"
          },

          "memory": {
            "format": "{used} / {total} MB",
            "tooltop-format": "Memory: {used} / {total} MB"
          },

          "network": {
            "format-up": "{interface} - {ipaddr}",
            "format-down": "No connection"
          },

          "battery": {
            "format": "{percentage}% {icon}",
            "tooltip-format": "Battery: {percentage}%"
          }
        }
      '';
    };
  };

  # Installs git and writes the following config to
  # .config/git/config
  programs.git = {
    enable = true;
    userName = "Ryan Hynes";
    userEmail= "131348960+rmjhynes@users.noreply.github.com";
    extraConfig = {
      init.defaultbranch = "main";
    };
    aliases = {
     st = "status";
     d = "diff";
     c = "commit";
     rb = "rebase";
     sw = "switch";
    };
  };

}

