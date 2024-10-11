{ pkgs, pkgs-unstable, ... }:
let
  jdk = pkgs-unstable.jdk;
  gradle = pkgs-unstable.gradle.override
  {
    java = jdk;
  };
in
{
  environment.systemPackages = 
  [
    gradle
    jdk
  ];

  environment.variables.JAVA_HOME = jdk.home;
}
