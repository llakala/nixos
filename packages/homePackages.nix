{
  pkgs,
  pkgs-stable,
  ...
}:

{

  home.packages =

  (with pkgs-stable;
  [
    discord
    gparted
    (firefox.overrideAttrs (oldAttrs:
    {
      buildCommand = oldAttrs.buildCommand +
      ''
        wrapProgram $out/bin/firefox \ --set MOZ_ENABLE_WAYLAND 0
      '';
    }))
    filezilla

  ])
  ++

  (with pkgs;
  [
    vscode
  ]);


}