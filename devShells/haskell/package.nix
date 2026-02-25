{ pkgs }:

pkgs.mkShell {
  packages = with pkgs; [
    ghc
    cabal-install
    stack
    haskell-language-server
    haskellPackages.hoogle
    haskellPackages.fast-tags
    haskellPackages.hlint
  ];
}
