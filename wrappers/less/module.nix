{ lib, self, ... }:

{
  options = {
    custom.lessConfig = lib.mkOption {
      type = lib.types.lines;
      default = null;
    };
  };

  config = {
    programs.less.enable = lib.mkForce false;
    custom.lessConfig = lib.removeSuffix "\n" (builtins.readFile ./less);

    environment.systemPackages = lib.singleton self.packages.less;
  };
}
