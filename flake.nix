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
        { system, ... }:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              (import ./overlays/default.nix)
            ];
            config = {
              allowUnfree = true;
            };
          };
          inherit (pkgs) lib callPackage;
          packages = lib.packagesFromDirectoryRecursive {
            inherit callPackage;
            directory = ./packages;
          };
          devShells = lib.packagesFromDirectoryRecursive {
            inherit callPackage;
            directory = ./devShells;
          };
          overlayAttrs = lib.packagesFromDirectoryRecursive {
            inherit callPackage;
            directory = ./overlays;
          };
        in
        {
          inherit overlayAttrs;
          inherit packages;
          inherit devShells;
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
