{ promise, ... }:
{
  options = {
    ignoreFile.default = ./ignore;
    settings = {
      default = promise (import ./settings.nix);
      mutators = [ "/gh" "/less" "/diff-so-fancy" ];
    };
  };

  mutations = {
    "/fish".abbreviations = import ./abbreviations.nix;
  };
}
