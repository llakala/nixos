lockPref("services.sync.declinedEngines", "");
lockPref("sidebar.verticalTabs", true);
lockPref("sidebar.main.tools", "");

// From https://discourse.nixos.org/t/can-someone-help-me-with-my-firefox-nix/69590/6
// Lets me inject userChrome into the wrapper, without having to resort to hm/hjem symlinking
try {
  let sss = Components.classes["@mozilla.org/content/style-sheet-service;1"].getService(Components.interfaces.nsIStyleSheetService);
  let uri = Services.io.newURI("file://@userChromeFile@", sss.USER_SHEET);
  if (!sss.sheetRegistered(uri, sss.USER_SHEET)) {
    sss.loadAndRegisterSheet(uri, sss.USER_SHEET);
  }
} catch(ex){
  Components.utils.reportError(ex.message);
}
