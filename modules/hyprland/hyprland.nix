{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wofi
    rofi-wayland
    waybar
    hyprpaper
  ];
}
