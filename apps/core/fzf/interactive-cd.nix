{ config, ... }:
{
  environment.variables = assert config.features.fuzzyCd == "zoxide"; {
    FZF_ALT_C_COMMAND = "zoxide query --list --score";
    FZF_ALT_C_OPTS = ''
      --height 40% --layout reverse --border rounded --nth 2.. --accept-nth 2.. --scheme=path --no-sort --exact --tiebreak="end,index"
    '';
  };
}
