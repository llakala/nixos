_:
{
  options = {
    configFile.default = ./lesskey;
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
