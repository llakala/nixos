{ writeTextFile, pkgs, lib, symlinkJoin }:

let
  # Equivalent to `writeShellApplication`
  # We don't actually expose this, instead exposing a wrapping function that lets us specify
  # fishCompletions
  _writeFishApplication =
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

  # Creates a derivation for the given fish completion. Exposed via `final`
  writeFishCompletion = name: fishCompletion:
  if fishCompletion == null then null
  else writeTextFile
  {
    name = "${name}.fish";
    destination = "/share/fish/vendor_completions.d/${name}.fish";
    text = fishCompletion;
  };

  # Final function to be actually exposed. Wraps both `_WriteFishApplication`
  # and `writeFishCompletion`. If completions exist, we symlinkJoin the two derivations,
  # so a command can easily specify its completions. All credit for concept goes to:
  # https://github.com/iynaix/dotfiles/blob/81fb43d72d001bc41041303bc2651d964713e607/lib.nix#L27
  # My logic is basically the same, but I specify writeFishApplication parameters manually,
  # rather than using intersectAttrs, since it had bad UX with passing arguments that
  # _writeFishApplication didn't actually support. If you know of a cleaner way to make a function
  # take all the arguments of another function, plus extras, let me kno!
  final =
  {
    name,
    text,
    meta ? {},
    runtimeInputs ? [ ],
    fishCompletion ? null
  }:
  let
    app = _writeFishApplication
    {
      inherit name text meta runtimeInputs;
    };
    completions = writeFishCompletion name fishCompletion;
  in
    if completions == null then app
    else symlinkJoin
    {
      inherit name;
      meta = app.meta;
      paths = lib.singleton app ++ lib.singleton completions;
    };

in
  final
