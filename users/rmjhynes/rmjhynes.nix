{
  config,
  pkgs,
  dotfiles,
  ...
}:

{
  imports = [
    ./config/hyprland.nix
    ./config/packages.nix
  ];

  home.username = "rmjhynes";
  home.homeDirectory = "/home/rmjhynes";
  home.stateVersion = "25.05";

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

  };

  # Installs git and writes the following config to
  # .config/git/config
  programs.git = {
    enable = true;
    userName = "Ryan Hynes";
    userEmail = "131348960+rmjhynes@users.noreply.github.com";
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
