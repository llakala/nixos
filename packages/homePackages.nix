{
  pkgs,
  pkgs-unstable,
  ...
}:

{

  home.packages =

  (with pkgs;
  [
    discord
    gparted
    (firefox.overrideAttrs (oldAttrs: {
      buildCommand = oldAttrs.buildCommand + ''
        wrapProgram $out/bin/firefox \
          --set MOZ_ENABLE_WAYLAND 0
      '';
    }))
    filezilla
    modrinth-app

  ])
  ++

  (with pkgs-unstable;
  [
    vscode
  ]);


}