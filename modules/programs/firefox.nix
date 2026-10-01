{ self, ... }:

{
  features = {
    browser = "firefox";
    pdfs = "firefox";
  };

  environment.systemPackages = [ self.wrappers.firefox.result ];

  environment.variables.BROWSER = "firefox"; # `man` likes having this
}
