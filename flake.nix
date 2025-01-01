{
  description = "devkit flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ flake-parts, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;
      perSystem = { system, ... }:
        let
          pkgs = import nixpkgs {
            inherit system;
          };

          inherit (builtins) readDir mapAttrs;
          inherit (pkgs.lib) pipe;
          inherit (pkgs.lib.attrsets) filterAttrs;

          callPackages = path:
            pipe path [
              readDir
              (filterAttrs (_: value: value == "directory"))
              (mapAttrs (name: _: pkgs.callPackage "${path}/${name}" { }))
            ];
        in
        {
          packages = callPackages ./packages;
          devShells = callPackages ./devShells;
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
