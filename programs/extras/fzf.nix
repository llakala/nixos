{ self, lib, ... }:

{
  environment.systemPackages = [ self.wrappers.fzf.drv ];

  environment.variables = {
    FZF_DEFAULT_OPTS = self.wrappers.fzf.defaultOpts;
    FZF_ALT_C_COMMAND = self.wrappers.fzf.alt-c.command;
    FZF_ALT_C_OPTS = self.wrappers.fzf.alt-c.opts;
    FZF_CTRL_R_OPTS = self.wrappers.fzf.ctrl-r.opts;
  };

  hm.programs.fish.interactiveShellInit = ''
    ${lib.getExe self.wrappers.fzf.drv} --fish | source
  '';
}
