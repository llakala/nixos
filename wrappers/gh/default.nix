{ adios }:
{
  options = {
    configDir.default = ./gh;
  };

  mutations = {
    "/fish".abbreviations = _: {
      gh = [
        { rpv = "repo view --web"; }
        { rpf = "repo fork --remote --clone"; }
        { prc = "pr create --web"; }
        { prc = "pr create --web"; }
        { prv = "pr view --web"; }
        { prm = "pr merge"; }
      ];
    };
  };
}
