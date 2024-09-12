{ pkgs }:

pkgs.mkShell {
  packages = with pkgs; [
    nodejs
    fnm
    bun
    yarn
    nodePackages.pnpm
  ];

  shellHook = /* bash */ ''
    if [ -e .node-version ] || [ -e .nvmrc ]; then
      eval "$(fnm env)"
      fnm use --install-if-missing --silent-if-unchanged
    fi
  '';
}
