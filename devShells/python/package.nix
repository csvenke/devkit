{
  pkgs,
  lib,
  zlib,
  stdenv,
  python3,
}:

let
  libraryPath = lib.makeLibraryPath [
    stdenv.cc.cc
    zlib
  ];
  python = python3.withPackages (ps: [
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
  shellHook = ''
    export "LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${libraryPath}"
  '';
}
