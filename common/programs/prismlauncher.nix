{ pkgs, ... }:

let
  # shrinks closure, since by default, this includes other jdks for old mc
  # versions
  myPrism = pkgs.prismlauncher.override {
    jdks = [ pkgs.jdk25 ];
  };
in {
  environment.systemPackages = [ myPrism ];
}
