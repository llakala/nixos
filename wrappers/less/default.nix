{ promise, ... }:
{
  options = {
    configFile.default = ./lesskey;
  };

  mutations = {
    "/git".settings = promise (
      { options, inputs, result }:
      let
        inherit (inputs.nixpkgs) lib;
      in {
        core.pager = lib.getExe result;
      }
    );
  };
}
