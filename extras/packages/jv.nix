{ writeShellApplication, pkgs }:

writeShellApplication
{
  name = "jv";

  bashOptions =
  [
    "nounset" # -u
    "errexit" # -e
    "pipefail"
    "errtrace" # -E
  ];

  runtimeInputs = with pkgs;
  [
    jdk17
  ];

  text =
  /* bash */
  ''
    FILE=$1
    NAME=$(basename "$FILE" .java)
    javac "$FILE" && java "$NAME"
  '';
}