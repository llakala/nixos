{

  boot.tmp =
  {
    # Let nix build temp files in RAM. May need to be disabled for a *huge* build
    useTmpfs = true;
  };

}
