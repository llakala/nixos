{ adios }:
{
  options = {
    flags.default = [
      "--RAW-CONTROL-CHARS" # make colors work better
      "--clear-screen"
      "--quit-if-one-screen"
      "--redraw-on-quit" # show the last less page in scrollback
      "--tilde" # Show `~` on empty lines
      "--incsearch"
      "--wordwrap"
      "--ignore-case"
      "--search-options=WR" # enable search wrapping, disable regex search
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
