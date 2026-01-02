{ wrapperModules, replaceVars }:
wrapperModules.firefox {
  policiesFiles = [
    ./policies/extensions.json
    ./policies/policies.json
    ./policies/preferences.json
    ./policies/searchEngines.json
  ];
  autoConfigFiles = [
    (replaceVars ./autoConfig.js { userChromeFile = ./userChrome.css; })
  ];
}
