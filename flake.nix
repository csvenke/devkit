{
  description = "devkit flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    neovim.url = "github:csvenke/neovim-flake";
    angular-language-server.url = "github:csvenke/angular-language-server-flake";
  };

  outputs = inputs@{ flake-parts, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;
      imports = [
        inputs.flake-parts.flakeModules.easyOverlay
      ];
      perSystem = { pkgs, system, ... }:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              inputs.neovim.overlays.default
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
          overlayAttrs = {
            devkit = callPackages ./packages;
          };
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
