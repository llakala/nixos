{ wrapperModules, wrappers, lib }:

wrapperModules.fzf {
  defaultOpts = lib.fileContents ./FZF_OPTS;
  shellintegration = {
    ctrlR = {
      opts = lib.fileContents ./CTRL_R_OPTS;
    };
    altC = {
      command = "${lib.getExe wrappers.zoxide} query --list --score";
      opts = lib.fileContents ./ALT_C_OPTS;
    };
  };
}
