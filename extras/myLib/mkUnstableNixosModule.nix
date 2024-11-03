{ lib, ... }:

let
  mkUnstableNixosModule = { newSource, module, ... }:
  {
    disabledModules = lib.singleton module;

    imports = lib.singleton
    (
      newSource.outPath + "/nixos/modules/" + module
    );
  };

in
  mkUnstableNixosModule
