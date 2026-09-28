_:
let
  withCursor = expansion: {
    setCursor = true;
    inherit expansion;
  };
in {
  options = {
    configDir.default = ./gh;
  };

  mutations = {
    "/fish".abbreviations = {
      gh = [
        { rpv = "repo view --web"; }
        { rpf = "repo fork --remote --clone"; }
        { prc = "pr create --web"; }
        { prch = withCursor "pr checkout %"; }
        { prv = "pr view --web"; }
        { prm = "pr merge"; }
      ];
    };
  };
}
