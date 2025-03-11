{ pkgs-unstable, pkgs, ... }:

{
  environment.systemPackages =
  [
    pkgs-unstable.gleam
    pkgs.erlang_27
    pkgs.rebar3
  ];
}
