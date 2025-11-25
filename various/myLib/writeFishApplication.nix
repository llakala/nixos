{ writeTextFile, pkgs, lib, symlinkJoin }:

{
  name,
  text,
  meta ? {},
  runtimeInputs ? [],
  completiions ? null
}:

let
  application = writeTextFile {
    inherit name meta;
    executable = true;
    destination = "/bin/${name}";
    allowSubstitutes = false; # It's my own scripts, they're not going to be substituted

    # TODO: maybe shebang is unnecessary?
    text = ''
      #!${lib.getExe pkgs.fish}
    ''
    + lib.optionalString (runtimeInputs != []) ''
       fish_add_path --path (string split : "${lib.makeBinPath runtimeInputs}")
    ''
    + text;
  };

  # Creates a derivation for the given fish completion. Thanks to let laziness,
  # if `completions` is null, this will never be evaluated
  completionsFile = writeTextFile {
    name = "${name}.fish";
    destination = "/share/fish/vendor_completions.d/${name}.fish";
    text = completiions;
  };

in
  # If completions exist, we symlinkJoin the two derivations, so a command can
  # easily specify its completions. All credit for concept goes to:
  # https://github.com/iynaix/dotfiles/blob/81fb43d72d001bc41041303bc2651d964713e607/lib.nix#L27
  # My logic is basically the same, but I cleaned it up for readability, and
  # don't use `intersectAttrs`
  if completiions == null then application
  else symlinkJoin {
    inherit name meta;
    paths = [ application completionsFile ];
  }
