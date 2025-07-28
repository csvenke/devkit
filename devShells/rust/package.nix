{ pkgs }:

pkgs.mkShell {
  packages = [
    pkgs.cargo
    pkgs.rustc
    pkgs.rust-analyzer
  ];
}
