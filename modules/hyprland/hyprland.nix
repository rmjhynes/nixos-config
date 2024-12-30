{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gtk4
    gtk3
    xdg-utils
    wofi
    rofi-wayland
    waybar
    hyprpaper
  ];
}
