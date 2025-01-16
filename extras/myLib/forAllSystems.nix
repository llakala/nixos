{ lib, nixpkgs }:

function:
  lib.genAttrs lib.systems.flakeExposed
  (system: function nixpkgs.legacyPackages.${system})
