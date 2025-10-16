{ symlinkJoin, less, makeWrapper, lib }:

let
  lessConfig = lib.removeSuffix "\n" (builtins.readFile ./less);
in symlinkJoin {
  name = "less-wrapped";
  paths = [ less ];
  buildInputs = [ makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/less --set LESS "${lessConfig}" --set LESSKEY_CONTENT "${builtins.readFile ./lesskey}"
  '';
}
