{ adios }:
{
  options = {
    ignoreFile.default = ./ignore;
    iniConfig.mutators = [ "/gh" "/git" "/less" "/diff-so-fancy" ];
  };

  mutations = {
    "/fish".abbreviations = _: import ./abbreviations.nix;
    "/git".iniConfig = { inputs }: import ./settings.nix { inherit inputs; };
  };
}
