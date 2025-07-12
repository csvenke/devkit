{
  description = "devkit flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{ flake-parts, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;
      imports = [
        inputs.flake-parts.flakeModules.easyOverlay
      ];
      perSystem =
        { pkgs, ... }:
        let
          inherit (pkgs) callPackage;
          angular-language-server = callPackage ./packages/angular-language-server { };
          css-variables-language-server = callPackage ./packages/css-variables-language-server { };
        in
        {
          overlayAttrs = {
            inherit angular-language-server;
            inherit css-variables-language-server;
          };
          packages = {
            inherit angular-language-server;
            inherit css-variables-language-server;
            format = callPackage ./packages/format { };
            github-release = callPackage ./packages/github-release { };
          };
          devShells = {
            angular = callPackage ./devShells/angular {
              inherit angular-language-server;
            };
            dotnet = callPackage ./devShells/dotnet { };
            haskell = callPackage ./devShells/haskell { };
            java = callPackage ./devShells/java { };
            node = callPackage ./devShells/node { };
            python = callPackage ./devShells/python { };
            rust = callPackage ./devShells/rust { };
          };
        };
      flake = {
        templates = {
          default = {
            path = ./templates/default;
            description = "Default template";
          };
        };
      };
    };
}
