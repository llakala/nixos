{ promise, ... }:
{
  options = {
    ignoreFile.default = ./ignore;
    settings.mutators = [ "/gh" "/git" "/less" "/diff-so-fancy" ];
  };

  mutations = {
    "/fish".abbreviations = import ./abbreviations.nix;
    "/git".settings = promise (import ./settings.nix);
  };
}
