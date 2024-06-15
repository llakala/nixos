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

  ])
  ++

  (with pkgs-unstable;
  [
    vscode
    modrinth-app
  ]);


}