{
  features.abbreviations = "fish";

  hm.programs.fish.shellAbbrs =
  {
    cn = "cd nixos"; # We make it generic, and leave Zoxide to find the proper directory.

    m = "man";
    py = "python";
    j = "java";

    src = "source";

    c = "cd";
  };

}
