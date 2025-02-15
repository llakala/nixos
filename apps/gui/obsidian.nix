{ pkgs, lib, ... }:

{
  features.math = "obsidian";
  environment.systemPackages = lib.singleton pkgs.obsidian;
}
