{ pkgs }:

pkgs.mkShell {
  packages = with pkgs; [
    fnm
    bun
    yarn
    pnpm
  ];

  shellHook = ''
    eval "$(fnm env --use-on-cd --version-file-strategy=recursive --shell bash)"
  '';
}
