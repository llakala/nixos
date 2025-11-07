{ self, ... }:

{
  features.browser = "firefox";
  features.pdfs = "firefox";

  environment.systemPackages = [ self.wrappers.firefox.drv ];

  environment.variables.BROWSER = "firefox"; # `man` likes having this

  hm.home.file.".mozilla/firefox/default/chrome/userChrome.css".source = self.wrappers.firefox.userChrome;
}
