{ self, ... }:

{
  features.prompt = "starship"; # If we ever stop using Starship, change this

  environment.systemPackages = [ self.wrappers.starship.drv ];
}
