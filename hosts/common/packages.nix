{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    vim
    tree
    nixfmt-rfc-style
  ];
}
