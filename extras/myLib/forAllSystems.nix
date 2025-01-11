{ lib, inputs }:

function:
  lib.genAttrs lib.systems.flakeExposed
  (system: function inputs.nixpkgs.legacyPackages.${system})
