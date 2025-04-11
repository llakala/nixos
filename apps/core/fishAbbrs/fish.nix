{
  features.abbreviations = "fish";

  hm.programs.fish.shellAbbrs =
  {
    # We make it generic, and leave Zoxide to find the proper directory.
    cn = "cd nixos";

    m = "man";
    py = "python";
    j = "java";

    src = "source";

    c = "cd";
  };

}
