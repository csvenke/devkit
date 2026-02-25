{ pkgs }:

pkgs.mkShell {
  packages = with pkgs; [
    jdk
    maven
    gradle
    jdt-language-server
  ];
}
