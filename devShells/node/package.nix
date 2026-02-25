{ pkgs }:

pkgs.mkShell {
  packages = with pkgs; [
    nodejs
    pnpm
    bun
    fnm
  ];

  shellHook = /* bash */ ''
    if [ -e .node-version ] || [ -e .nvmrc ]; then
      eval "$(fnm env --shell bash)"
      fnm use --install-if-missing --silent-if-unchanged > /dev/null
    fi
  '';
}
