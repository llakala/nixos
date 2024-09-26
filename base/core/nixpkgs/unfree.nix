{
  path,
  runCommandLocal,
}:
runCommandLocal "nixpkgs-configured" { src = path; } ''
  mkdir -p $out

  substitute $src/flake.nix $out/flake.nix \
    --replace-fail "{ inherit system; }" "{ inherit system; config.allowUnfree = true; }"

  cp --update=none -Rt $out $src/*
''