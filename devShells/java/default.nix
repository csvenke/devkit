{ pkgs }:

pkgs.mkShell {
  packages = [
    pkgs.jdk
    pkgs.jdt-language-server
    pkgs.maven
    pkgs.gradle
  ];
}
