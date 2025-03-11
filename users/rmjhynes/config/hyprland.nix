{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "ALT";
      "$fileManager" = "dolphin";

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
        inactive_opacity = 0.8;
  
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

      # Keybinds
      bind = [
        "$mod, RETURN, exec, ghostty"
	"$mod, Q, killactive"
	"$mod, M, exit"
	"$mod, F, exec, $fileManager"
	"$mod, B, exec, firefox"
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
}

