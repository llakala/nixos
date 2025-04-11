{ llakaLib, pkgs }:

llakaLib.writeFishApplication
{
  # Java Compile
  name = "jc";

  runtimeInputs = with pkgs;
  [
    jdk17
    fd
  ];

  text =
  /* fish */
  ''
    set FILE $argv[1]
    set NAME (basename "$FILE" .java)
    javac "$FILE" && java "$NAME"
  '';

  # Only show Java files.
  fishCompletion =
  /* fish */
  ''
    complete -c jc --no-files --argument "(fd -d 1 --extension java)"
  '';
}
