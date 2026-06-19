{ self, ... }:

{
  features = {
    browser = "firefox";
    pdfs = "firefox";
  };

  environment.systemPackages = [ self.wrappers.firefox.drv ];

  environment.variables.BROWSER = "firefox"; # `man` likes having this
}
