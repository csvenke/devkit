{ pkgs }:

pkgs.mkShell {
  packages = [
    (pkgs.python3.withPackages (ps: [ ps.pip ps.pipx ]))
    pkgs.pyright
    pkgs.ruff-lsp
  ];
}

