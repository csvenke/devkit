{ pkgs }:

pkgs.mkShell {
  packages = with pkgs; [
    nodejs
    pnpm
    yarn
    bun
    deno
    fnm
  ];

  shellHook = ''
    if [ -e .node-version ] || [ -e .nvmrc ]; then
      eval "$(fnm env --shell bash)"
      fnm use --install-if-missing --silent-if-unchanged > /dev/null
    fi
  '';
}
