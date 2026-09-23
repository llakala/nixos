{ self, ... }:

{
  features.prompt = "starship"; # If we ever stop using Starship, change this

  environment.variables.STARSHIP_LOG = "error";
  environment.systemPackages = [ self.wrappers.starship.drv ];
}
