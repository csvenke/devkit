{ pkgs }:

pkgs.mkShell {
  buildInputs = [
    pkgs.ghc
    pkgs.cabal-install
    pkgs.stack
    pkgs.haskell-language-server
    pkgs.haskellPackages.hoogle
    pkgs.haskellPackages.fast-tags
  ];
}
