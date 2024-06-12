{
  hostVars,
  ...
}:

{
  programs.git =
  {
    enable = true;
    userName = hostVars.fullName;
    userEmail = "ellakalle6@gmail.com";
  };
}