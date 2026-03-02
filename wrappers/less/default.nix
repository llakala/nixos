_:
{
  options = {
    configFile.default = ./lesskey;

    # 692 fixes https://github.com/gwsw/less/issues/710
    # waiting on https://github.com/NixOS/nixpkgs/pull/490763 to make it off
    # staging
    package.defaultFunc =
      { inputs }:
      let
        inherit (inputs.nixpkgs.pkgs) less fetchurl;
      in
      less.overrideAttrs {
        version = "692";
        src = fetchurl {
          url = "https://www.greenwoodsoftware.com/less/less-692.tar.gz";
          hash = "sha256-YTAPYDeY7PHXeGVweJ8P8/WhrPB1pvufdWg30WbjfRQ=";
        };
      };
  };

  mutations = {
    "/git".settings =
      { options, inputs }:
      let
        inherit (inputs.nixpkgs) lib;
        finalWrapper = options {};
      in {
        core.pager = lib.getExe finalWrapper;
      };
  };
}
