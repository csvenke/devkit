{ pkgs }:

pkgs.mkShell {
  packages = with pkgs; [
    ghc
    cabal-install
    stack
    haskellPackages.hoogle
    haskellPackages.fast-tags
    haskellPackages.hlint
  ];
}
