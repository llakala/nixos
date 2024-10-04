{ config, ... }:

{
  environment.shellAliases =
  {
    evalue = "nix eval --json '${config.baseVars.configDirectory}#nixosConfigurations.${config.hostVars.hostName}.config.$1' | jq";
    
  };
}