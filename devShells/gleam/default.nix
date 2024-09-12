{ pkgs }:

pkgs.mkShell {
  packages = [
    pkgs.gleam
  ];
}
