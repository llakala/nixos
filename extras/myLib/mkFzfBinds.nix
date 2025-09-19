# Code logic is all from https://github.com/HexoKnight/nixos/blob/ba222aaa308a38e512094032ec87085158335ccf/modules/home-manager/fzf.nix
# All credit goes to them, I'm just a happy customer
# All I did was refactor a bit to make the code a little more modular
{ lib }:

let
  delimiterList = map lib.stringToCharacters [
    "()" "[]" "{}" "<>"
    "~" "!" "@" "#" "$" "%" "^" "&" "*" ";" "/" "|"
  ];

  withArg = name: arg: {
    inherit name arg;
  };

  mkDelimiterPair = actionArg: lib.findFirst
    (
      pair: builtins.match
        ".*${lib.escapeRegex (lib.last pair)}[+,].*"
        actionArg == null
    )
    (throw "no valid delimiters for fzf bind action arg: '${actionArg}'")
    delimiterList;


  mkAction = actionName: actionArgs: map (
    actionArg:
    let
      delimiterPair = mkDelimiterPair actionArg;
    in
      if actionArg == null then actionName
      else lib.concatStrings [
        actionName
        (lib.head delimiterPair)
        actionArg
        (lib.last delimiterPair)
      ]
  ) actionArgs;

  mkActionList = actions: lib.concatMap
  (action:
    let
      actionName = action.name or action;
      actionArgs = lib.toList (action.arg or null);
    in
      mkAction actionName actionArgs
  )
  (
    if builtins.isAttrs actions && !actions ? name
      then lib.mapAttrsToList withArg actions
    else
      lib.toList actions
  );

  final = binds: lib.mapAttrsToList
    (key: actions:
      let
        actionList = mkActionList actions;
      in lib.concatStrings [
        key
        ":"
        (builtins.concatStringsSep "+" actionList)
      ]
    )
    binds;

in final
