# All logic from https://github.com/arcnmx/nixexprs/blob/master/modules/home/tridactyl.nix
# Reformatted to match my preferences and to no longer use `with lib;`
{ config, lib, ... }:

let
  cfg = config.custom.tridactyl;

  cmdType = lib.types.str; # TODO: add fancier types for "js" etc that escape things and compose better
  settingType = lib.types.either lib.types.bool lib.types.str;

  asFile = name: contentsOrPath:
    if lib.types.path.check contentsOrPath
      then contentsOrPath
    else
      builtins.toFile name contentsOrPath;

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

    autocmdName = name:
    (
      lib.toUpper (lib.substring 0 1 name)
    )
    + lib.substring 1
    (
      lib.stringLength name
    )
    name;

    autocmds = name: list: lib.concatStringsSep "\n"
    (
      map
      (
        value:
        "autocmd ${configStrs.autocmdName name} ${configStrs.urlPattern value.urlPattern} ${configStrs.cmd value.cmd}"
      )
      list
    );

    autocontain = { urlPattern, container, isDomainPattern, ... }:
      "autocontain${lib.optionalString (!isDomainPattern) " -u"} ${urlPattern} ${
        if container == null then throw "default container unimplemented" else container
      }";

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
    themes = lib.mkOption {
      description = "tridactyl theme data";
      type = lib.types.attrsOf
      (
        lib.types.either
          lib.types.lines
          lib.types.path
      );
      default = { };
    };

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

    sanitise =
    {
      local = lib.mkOption
      {
        type = lib.types.bool;
        default = false;
      };

      sync = lib.mkOption
      {
        type = lib.types.bool;
        default = false;
      };

      excmd = lib.mkOption
      {
        type = lib.types.str;
        internal = true;
        default = lib.concatStringsSep " "
        [
          "sanitise"
          (lib.optionalString cfg.sanitise.local "tridactyllocal")
          (lib.optionalString cfg.sanitise.sync "tridactylsync")
        ]
        + lib.optionalString
          ( cfg.settings ? storageloc )
          "\n${configStrs.setting "storageloc" cfg.settings.storageloc}";
      };
    };

    autocontain = lib.mkOption
    {
      description = "Automatically open a domain in a specified container";
      default = { };
      type = lib.types.attrsOf
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

              isDomainPattern = lib.mkOption
              {
                type = lib.types.bool;
                default = true;
              };

              container = lib.mkOption
              {
                type = lib.types.nullOr lib.types.str;
              };
            };
          }
        )
      );
    };

    autocmd =
    let
      auType = lib.types.submodule
      (
        { ... }:
        {
          options =
          {
            urlPattern = lib.mkOption
            {
              type = lib.types.nullOr lib.types.str;
              default = null;
              description = "Regex pattern of url to match, or null to trigger always";
            };

            cmd = lib.mkOption
            {
              type = cmdType;
              description = "Command to run when the event triggers.";
            };
          };
        }
      );
      type = lib.types.listOf auType;
      default = [ ];
    in
    {
      triStart = lib.mkOption
      {
        inherit type default;
        description = "Commands to run when the browser starts";
      };

      docStart = lib.mkOption
      {
        inherit type default;
        description = "Commands to run when a page begins to load (DocStart)";
      };

      docLoad = lib.mkOption
      {
        inherit type default;
        description = "Commands to run when a page is loaded (DOMContentLoaded)";
      };

      docEnd = lib.mkOption
      {
        inherit type default;
        description = "Commands to run when a page is left (pagehide event)";
      };

      tabEnter = lib.mkOption
      {
        inherit type default;
        description = "Commands to run when a tab is focused";
      };

      tabLeft = lib.mkOption
      {
        inherit type default;
        description = "Commands to run when a tab is left";
      };

      fullscreenEnter = lib.mkOption
      {
        inherit type default;
        description = "Commands to run when fullscreen mode is entered";
      };

      fullscreenLeft = lib.mkOption
      {
        inherit type default;
        description = "Commands to run when fullscreen mode is left";
      };

      fullscreenChange = lib.mkOption
      {
        inherit type default;
        description = "Commands to run when fullscreen mode is changed";
      };
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
        (cfg.sanitise.local || cfg.sanitise.sync)
        (lib.mkBefore cfg.sanitise.excmd)
      )
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
        (cfg.autocmd != { })
        (
          lib.concatStringsSep "\n"
            (lib.mapAttrsToList configStrs.autocmds cfg.autocmd)
        )
      )
      (
        lib.mkIf
        (cfg.autocontain != { })
        (
          lib.concatStringsSep "\n"
            (lib.mapAttrsToList (_: configStrs.autocontain) cfg.autocontain)
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
    }
    // lib.mapAttrs'
    (
      name: source: lib.nameValuePair
        "tridactyl/themes/${name}.css"
        {
          source = asFile "${name}.css" source;
        }
    ) cfg.themes;
  };
}
