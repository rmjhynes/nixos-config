{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    vim
    tree
  ];
}
