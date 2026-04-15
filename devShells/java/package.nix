{ pkgs }:

pkgs.mkShell {
  packages = with pkgs; [
    jdk
    maven
    gradle
  ];
}
