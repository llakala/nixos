# All logic from https://github.com/arcnmx/nixexprs/blob/8cce84df087eb40f6c0681575f2551ffcb0e3ca8/modules/home/tridactyl.nix#L2
# Reformatted to match my preferences and to no longer use `with lib;`
# Many options removed so I can debug the module and only work with what I understand
# Use the above link if you want to see the real functionality
{ config, lib, ... }:

let
  cfg = config.custom.tridactyl;

  # TODO: add fancier types for "js" etc that escape things and compose better
  cmdType = lib.types.str;
  settingType = lib.types.either lib.types.bool lib.types.str;

  configStrs =
  {
    cmd = cmd: cmd;
    alias = name: cmd: "alias ${name} ${configStrs.cmd cmd}";

    settingValue = value:
      if lib.isBool value then
        (if value then "true" else "false")
      else value;

    setting = name: value:
      "set ${name} ${configStrs.settingValue value}";

    urlSettings = name: list: lib.concatStringsSep "\n"
    (map
      (
        value:
        "seturl ${value.urlPattern} ${name} ${configStrs.settingValue value.value}"
      )
      (lib.attrValues list)
    );

    urlPattern = url:
      if url == null then ".*"
      else url;


    keyseq = mods: key:
    let
      modStr = lib.concatStrings
      (
        map
        (
          mod:
          {
            alt = "A";
            ctrl = "C";
            meta = "M";
            shift = "S";
          }
          .${mod}
        )
        (lib.toList mods)
      );

      escapedKey = lib.mapNullable lib.head
      (
        builtins.match "<(.*)>" key
      );

      strippedKey = if escapedKey == null then key else escapedKey;

    in
      if mods == [ ]
        then key
      else
        "<${modStr}-${strippedKey}>";

    bindingLine = config: mode:
    let
      cmd = "${lib.optionalString (config.cmd == null) "un"}bind${
        lib.optionalString (config.urlPattern != null) "url"
      }";

      cmdStr = lib.optionalString
        (config.cmd != null)
        " ${config.cmd}";

    in
      if config.urlPattern != null then
        "${cmd} ${config.urlPattern} ${mode} ${config.binding}${cmdStr}"
      else
        "${cmd}${lib.optionalString (mode != "normal") " --mode=${mode}"} ${config.binding}${cmdStr}";

    binding = config: lib.concatStringsSep "\n" (map (configStrs.bindingLine config) (lib.toList config.mode));
  };
in
{
  options.custom.tridactyl = {
    enable = lib.mkEnableOption "tridactyl Firefox plugin";

    bindings = lib.mkOption
    {
      default = { };
      type = lib.types.listOf
      (
        lib.types.submodule
        (
          { config, ... }:
          {
            options =
            {
              urlPattern = lib.mkOption
              {
                type = lib.types.nullOr lib.types.str;
                default = null;
                description = "Restrict keybinding to pages that match a regex pattern";
              };

              mode = lib.mkOption
              {
                default = "normal";
                type =
                  let ty = lib.types.enum
                  [
                    "normal"
                    "ex"
                    "input"
                    "insert"
                    "ignore"
                    "hint"
                    "visual"
                    "browser"
                    ];
                  in lib.types.either
                    ty
                    (lib.types.listOf ty);
              };

              key = lib.mkOption
              {
                type = lib.types.str;
              };

              mods = lib.mkOption
              {
                default = [ ];
                type = let ty = lib.types.enum
                [
                  "alt"
                  "ctrl"
                  "meta"
                  "shift"
                ];
                in lib.types.either
                  ty
                  (lib.types.listOf ty);
              };

              cmd = lib.mkOption
              {
                type = lib.types.nullOr cmdType;
              };

              binding = lib.mkOption
              {
                type = lib.types.str;
                default = configStrs.keyseq config.mods config.key;
              };
            };
          }
        )
      );
    };

    exalias = lib.mkOption
    {
      type = lib.types.attrsOf cmdType;
      default = { };
    };

    settings = lib.mkOption
    {
      type = lib.types.attrsOf settingType;
      default = { };
    };

    urlSettings = lib.mkOption
    {
      default = { };
      type = lib.types.attrsOf
      (
        lib.types.attrsOf
        (
          lib.types.submodule
          (
            { name, ... }:
            {
              options =
              {
                urlPattern = lib.mkOption
                {
                  type = lib.types.str;
                  default = name;
                };

                value = lib.mkOption
                {
                  type = settingType;
                };
              };
            }
          )
        )
      );
    };

    extraConfig = lib.mkOption
    {
      type = lib.types.lines;
      default = "";
    };
  };

  config = lib.mkIf cfg.enable
  {
    custom.tridactyl.extraConfig = lib.mkMerge
    [
      (
        lib.mkIf
        (cfg.exalias != { })
        (
          lib.concatStringsSep "\n"
            (lib.mapAttrsToList configStrs.alias cfg.exalias)
        )
      )
      (
        lib.mkIf
        (cfg.settings != { })
        (
          lib.concatStringsSep "\n"
          (
            lib.mapAttrsToList
              configStrs.setting
              (builtins.removeAttrs cfg.settings [ "storageloc" ])
          )
        )
      )
      (
        lib.mkIf
        (cfg.urlSettings != { })
        (
          lib.concatStringsSep "\n"
          (lib.mapAttrsToList configStrs.urlSettings cfg.urlSettings)
        )
      )
      (
        lib.mkIf
        (cfg.bindings != { })
        (
          lib.concatStringsSep "\n"
          (map configStrs.binding cfg.bindings)
        )
      )
    ];
    # TODO: programs.firefox.enableTridactylNative = true;
    # TODO: implement fixamo and guiset via firefox module's profile settings
    # see also: https://github.com/tridactyl/tridactyl/blob/master/src/lib/css_util.ts
    # TODO: set this per profile instead of globally? can we use user.js to set up storage and tell tridactyl what to load on startup..? or even just fill storage instead of requiring the native extension for tridactylrc loading at all.
    hm.xdg.configFile =
    {
      "tridactyl/tridactylrc".text = cfg.extraConfig;
    };
  };
}
