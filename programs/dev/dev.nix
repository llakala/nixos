{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nodejs
    typescript
    ruby
    lua
  ];
}
