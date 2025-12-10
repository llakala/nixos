{ adios }:

{
  name = "diff-so-fancy";

  inputs = {
    nixpkgs.path = "/nixpkgs";
    git.path = "/git";
  };

  impl =
    { inputs }:
    let
      inherit (inputs.nixpkgs) pkgs;
      inherit (pkgs) symlinkJoin makeWrapper;
    in
    symlinkJoin {
      name = "diff-so-fancy-wrapped";
      paths = [ pkgs.diff-so-fancy ];
      buildInputs = [ makeWrapper ];
      postBuild = /* bash */ ''
        wrapProgram $out/bin/diff-so-fancy \
          --set GIT_CONFIG_GLOBAL "${inputs.git.configDir}/git/config" \
      '';
      meta.mainProgram = "diff-so-fancy";
    };
}
