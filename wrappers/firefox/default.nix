_:
{
  options = {
    # This is technically unfree (see
    # https://github.com/NixOS/nixpkgs/pull/385857), but it makes eval times a
    # lot faster, since normal firefox-unwrapped requires a huge closure, like
    # an entire wasm crosschain.
    package.defaultFunc = { inputs }: inputs.nixpkgs.pkgs.firefox-bin-unwrapped;

    policiesFiles.default = [
      ./policies/extensions.json
      ./policies/policies.json
      ./policies/preferences.json
      ./policies/searchEngines.json
    ];
    autoConfigFiles.defaultFunc =
      { inputs }:
      let
        inherit (inputs.nixpkgs) pkgs;
        inherit (pkgs) replaceVars;
      in [
        (replaceVars ./autoConfig.js {
          userChromeFile = ./userChrome.css;
          bookmarksFile = ./bookmarks.html;
        })
      ];
  };
}
