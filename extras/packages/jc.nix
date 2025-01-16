{ llakaLib, pkgs }:

llakaLib.writeFishApplication
{
  name = "jc"; # Java Compile

  runtimeInputs = with pkgs;
  [
    jdk17
  ];

  text =
  /* fish */
  ''
    set FILE $argv[1]
    set NAME (basename "$FILE" .java)
    javac "$FILE" && java "$NAME"
  '';
}