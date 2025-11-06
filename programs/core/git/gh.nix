{ config, self, lib, ... }:

{
  environment.systemPackages = [ self.wrappers.gh.drv ];

  hm.programs.git.iniContent = {
    credential."https://github.com".helper = "${lib.getExe self.wrappers.gh.drv} auth git-credential";
  };

  hm.programs.fish.shellAbbrs =
  assert config.features.abbreviations == "fish"; {
    ghrpv = "gh repo view --web";
    ghrpf = "gh repo fork --remote --clone";

    ghprc = "gh pr create --web";
    ghprv = "gh pr view --web";
    ghprm = "gh pr merge";
  };
}
