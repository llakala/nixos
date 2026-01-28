_:
{
  options = {
    ignoreFile.default = ./ignore;
    settings.mutators = [ "/gh" "/git" "/less" "/diff-so-fancy" ];
  };

  mutations = {
    "/fish".abbreviations = _: import ./abbreviations.nix;
    "/git".settings = { inputs }: import ./settings.nix { inherit inputs; };
  };
}
