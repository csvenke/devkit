{ pkgs }:

let
  libraryPath = pkgs.lib.makeLibraryPath [
    pkgs.stdenv.cc.cc
    pkgs.zlib
  ];
  python = pkgs.python312.withPackages (ps: [
    ps.pip
    ps.pipx
  ]);
in
pkgs.mkShell {
  packages = [
    python
    pkgs.pyright
    pkgs.ruff
  ];

  LD_LIBRARY_PATH = libraryPath;
}
