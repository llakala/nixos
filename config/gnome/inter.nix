{ lib, pkgs, ... }:

{
  fonts =
  {
    packages = lib.singleton pkgs.inter;

    fontconfig.defaultFonts =
    {
      serif = lib.singleton "Inter";
      sansSerif = lib.singleton "Inter";
    };
  };
}
