{ self, ... }:

let
  fzfOptions = self.wrappers.fzf.options;
in {
  environment.systemPackages = [ fzfOptions.package ];

  environment.variables = {
    FZF_DEFAULT_OPTS = fzfOptions.defaultOpts;

    FZF_ALT_C_COMMAND = fzfOptions.shellIntegration.alt-c.command;
    FZF_ALT_C_OPTS = fzfOptions.shellIntegration.alt-c.opts;

    FZF_CTRL_R_OPTS = fzfOptions.shellIntegration.ctrl-r.opts;
    FZF_COMPLETION_OPTS = fzfOptions.shellIntegration.completion.opts;
  };
}
