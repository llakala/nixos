{ self, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.fzf ];

  environment.variables = {
    FZF_DEFAULT_OPTS = self.wrappers.fzf.defaultOpts;

    FZF_ALT_C_COMMAND = self.wrappers.fzf.shellIntegration.alt-c.command;
    FZF_ALT_C_OPTS = self.wrappers.fzf.shellIntegration.alt-c.opts;

    FZF_CTRL_R_OPTS = self.wrappers.fzf.shellIntegration.ctrl-r.opts;
  };
}
