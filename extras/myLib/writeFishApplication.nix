{ writeTextFile, pkgs, lib }:

let
  writeFishApplication =
  { name, text, meta ? {}, runtimeInputs ? [ ] }:
  writeTextFile
  {
    inherit name meta;
    executable = true;
    destination = "/bin/${name}";
    allowSubstitutes = false; # It's my own scripts, they're not going to be substituted
    text =
    ''
      #!${lib.getExe pkgs.fish}
    ''

    + lib.optionalString (runtimeInputs != [ ])
    ''
       fish_add_path --path (string split : "${lib.makeBinPath runtimeInputs}")
    ''
    +
    ''
      ${text}
    '';
  };
in
writeFishApplication
