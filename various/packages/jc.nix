{ myLib, pkgs }:

myLib.writeFishApplication {
  name = "jc"; # Java Compile

  runtimeInputs = with pkgs; [
    jdk
    fd
  ];

  text = # fish
  ''
    set FILE $argv[1]
    set NAME (basename "$FILE" .java)
    javac "$FILE" && java "$NAME"
  '';

  # Only show Java files.
  fishCompletion = # fish
  ''
    complete -c jc --no-files --argument "(fd -d 1 --extension java)"
  '';
}
