{ pkgs, ... }:

{
  environment.systemPackages = with pkgs;
  [
    nodejs
    typescript
    go
    cargo
    rustc
    ruby
  ];
}