{ config, pkgs, dotfiles, ... }:

{
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

  programs.zsh = {
    # Use zsh as default shell
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "powerlevel10k/powerlevel10k";
      plugins = [
        "git"
	"zsh-autosuggestions"
	"zsh-syntax-highlighting"
      ];
    };
  };

  home.packages = with pkgs; [
   ripgrep
   oh-my-zsh
   zsh-powerlevel10k
   zsh-autosuggestions
   zsh-syntax-highlighting
   dracula-icon-theme
   dracula-theme
   vimPlugins.dracula-vim
  ];
}

