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
    ".config/ghostty/config".source = dotfiles + "/ghostty.conf";
    "nixos_install.sh".source = dotfiles + "/scripts/nixos_install.sh";

    # Set wallpaper with hyprpaper
    ".config/hypr/hyprpaper.conf" = {
      text = ''
        preload = /home/rmjhynes/repos/nixos-config/modules/nix-wallpaper.png
        wallpaper = , /home/rmjhynes/repos/nixos-config/modules/nix-wallpaper.png
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

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "ALT";

      # Commands to run on startup
      exec-once = [
        "waybar"
	"hyprpaper"
      ];

      monitor = [
        "virtual-1,preferred,auto,0.5"
      ];

      general = {
        gaps_in = 5;
	gaps_out = 20;
	border_size = 2;
	layout = "dwindle";
       };

       input = {
         follow_mouse = 1;
	 sensitivity = 0;
       };

       dwindle = {
         pseudotile = true;
	 preserve_split = true;
       };
      
      decoration  = {
        rounding = 10;
  
        # Change transparency of focused and unfocused windows
        active_opacity = 1.0;
        inactive_opacity = 1.0;
  
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          #color = rgba(1a1a1aee);
        };
  
        # https://wiki.hyprland.org/Configuring/Variables/#blur
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
  
          vibrancy = 0.1696;
        };
      };
      bind = [
        "$mod, RETURN, exec, foot"
	"$mod, C, killactive"
	"$mod, M, exit"
	"$mod, E, exec, $fileManager"
	"$mod, V, togglefloating"
	#"$mod, W, exec, wofi --show drun"
	"$mod, S, exec, rofi -show drun"
	"$mod, P, pseudo" # dwindle
	"$mod, J, togglesplit" # dwindle

	# Move focus with mainMod + arrow keys
	"$mod, left, movefocus, l"
	"$mod, right, movefocus, r"
	"$mod, up, movefocus, u"
	"$mod, down, movefocus, d"
      ];
    };
  };

  home.packages = with pkgs; [
   ripgrep
  ];
}

