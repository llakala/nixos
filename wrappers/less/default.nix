{ promise, ... }:
{
  options = {
    configFile.default = ./lesskey;
  };

  mutations = {
    "/git".settings = promise (
      { options, inputs }:
      let
        inherit (inputs.nixpkgs) lib;
        finalWrapper = options {};
      in {
        core.pager = lib.getExe finalWrapper;
      }
    );
  };
}
