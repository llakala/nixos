{ vars, ... }:

{
  programs.git =
  {
    enable = true;
    userName = vars.fullName;
    userEmail = "ellakalle6@gmail.com";
  };
}