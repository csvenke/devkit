{
  description = "devkit flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    angular-language-server.url = "github:csvenke/angular-language-server-flake";
  };

  outputs = inputs@{ flake-parts, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;
      perSystem = { pkgs, system, ... }:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              inputs.angular-language-server.overlays.default
            ];
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
