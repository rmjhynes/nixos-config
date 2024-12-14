{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    python314
    go
    terraform
  ];
}
