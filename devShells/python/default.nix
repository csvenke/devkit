{ pkgs }:

pkgs.mkShell {
  packages = with pkgs; [
    (python3.withPackages (ps: [ ps.pip ps.pipx ]))
    pyright
    ruff
  ];
}

