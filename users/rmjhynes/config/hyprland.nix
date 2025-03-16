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

  # rofi app launcher config and Dracula theme
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    location = "center";
    font = "MesloLGS NF";

    # Path to terminal which will be used to run console applications
    #terminal = "/run/current-system/sw/bin/ghostty";
    terminal = "${pkgs.ghostty}/bin/ghostty";

    extraConfig = {
      show-icons = true;

      # Format in which to display apps
      drun-display-format = "{icon} {name}";

      # Search prompt in drun mode
      display-drun = "Search";
    };

    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
      /* Dracula theme colour palette */
      drac-bgd = mkLiteral "#282a36";
      drac-cur = mkLiteral "#44475a";
      drac-fgd = mkLiteral "#f8f8f2";
      drac-cmt = mkLiteral "#6272a4";
      drac-cya = mkLiteral "#8be9fd";
      drac-grn = mkLiteral "#50fa7b";
      drac-ora = mkLiteral "#ffb86c";
      drac-pnk = mkLiteral "#ff79c6";
      drac-pur = mkLiteral "#bd93f9";
      drac-red = mkLiteral "#ff5555";
      drac-yel = mkLiteral "#f1fa8c";
    in {

      "*" = {
        font = "Jetbrains Mono 12";

        foreground-color = drac-fgd;
        background-color = drac-bgd;
        active-background-color = drac-pnk;
        urgent-background-color = drac-red;
        urgent-foreground-color = drac-bgd;

        selected-normal-background-color = drac-pnk;
        selected-urgent-background-color = drac-red;
        selected-active-background-color = drac-pnk;
        separatorcolor = drac-pnk;
        bordercolor = drac-cmt;
      };

      "#window" = {
        background-color = drac-bgd;
        border = 3;
        border-radius = 6;
        border-color = drac-cmt;
        padding = 15;
      };

      "#mainbox" = {
        border = 0;
        padding = 0;
      };

      "#message" =  {
        border = mkLiteral "0px";
        border-color = drac-pnk;
        padding = mkLiteral "1px";
      };

      "#textbox" = {
        text-color = drac-fgd;
      };

      "#listview" = {
        fixed-height = 0;
        border = mkLiteral "0px";
        border-color = drac-cmt;
        spacing = mkLiteral "2px";
        scrollbar = false;
        padding = mkLiteral "2px 0px 0px";
      };

      "#element" = {
        border = 0;
        padding = mkLiteral "3px";
      };

      "#element.normal.normal" = {
        background-color = drac-bgd;
        text-color = drac-fgd;
      };

      "#element.normal.urgent" = {
        background-color = drac-red;
        text-color = drac-bgd;
      };

      "#element.normal.active" = {
        background-color = drac-pnk;
        text-color = drac-bgd;
      };

      "#element.selected.normal" = {
        background-color = drac-pnk;
        text-color = drac-fgd;
      };

      "#element.selected.urgent" = {
        background-color = drac-red;
        text-color = drac-fgd;
      };

      "#element.selected.active" = {
        background-color = drac-pnk;
        text-color = drac-bgd;
      };

      "#element.alternate.normal" = {
        background-color = drac-bgd;
        text-color = drac-fgd;
      };

      "#element.alternate.urgent" = {
        background-color = drac-red;
        text-color = drac-fgd;
      };

      "#element.alternate.active" = {
        background-color = drac-pnk;
        text-color = drac-fgd;
      };

      "#scrollbar" = {
        width = mkLiteral "2px";
        border = 0;
        handle-width = mkLiteral "8px";
        padding = 0;
      };

      "#sidebar" = {
        border = mkLiteral "2px dash 0px 0px";
        border-color = drac-pnk;
      };

      "#button.selected" = {
        background-color = drac-pnk;
        text-color = drac-fgd;
      };

      "#inputbar" = {
        spacing = 0;
        text-color = drac-fgd;
        padding = mkLiteral "1px";
      };

      "#case-indicator" = {
        spacing = 0;
        text-color = drac-fgd;
      };

      "#entry" = {
        spacing = 0;
        text-color = drac-cya;
      };

      "#prompt" = {
        spacing = 0;
        text-color = drac-grn;
      };

      "#inputbar" = {
        children = map mkLiteral [ "prompt" "textbox-prompt-colon" "entry" "case-indicator" ];
      };

      "#textbox-prompt-colon" = {
        expand = false;
        str = "--->";
        margin = mkLiteral "0px 0.3em 0em 0em";
        text-color = drac-pur;
      };

      "#element-text" = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };

      "#element-icon" = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };

    };

  };

}

