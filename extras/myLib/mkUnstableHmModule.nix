{ lib, ... }:

let
  mkUnstableHmModule = { moduleSource, module, ... }:
  {
    home-manager.users.emanresu = # We have the `hm` alias for doing this within config, but myLib shouldn't rely on that
    {
      disabledModules = lib.singleton module;

      imports = lib.singleton
      (
        moduleSource + "/modules/" + module
      );
    };
  };
in
  mkUnstableHmModule
