{ adios }:
{
  options = {
    flags.default = [
      "--RAW-CONTROL-CHARS"
      "--clear-screen"
      "--quit-if-one-screen"
      "--redraw-on-quit"
      "--tilde"
      "--incsearch"
      "--wordwrap"
      "--ignore-case"
      "--search-options=WR"
    ];
    keybindsFile.default = ./lesskey;
  };

  mutations = {
    "/git".iniConfig =
      { options, inputs }:
      let
        inherit (inputs.nixpkgs) lib;
        finalWrapper = options {};
      in {
        core.pager = lib.getExe finalWrapper;
      };
  };
}
