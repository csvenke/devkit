{ pkgs ? import <nixpkgs-unstable> { } }:

pkgs.mkShell {
  packages = with pkgs; [
    node2nix
    nodejs
    fnm
    bun
    yarn
    pnpm
    deno
  ];

  shellHook = ''
    if [ -e .node-version ] || [ -e .nvmrc ]; then
      eval "$(fnm env --shell bash)"
      fnm use --install-if-missing --silent-if-unchanged > /dev/null
    fi
  '';
}
