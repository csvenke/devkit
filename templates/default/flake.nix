{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devkit = {
      url = "github:csvenke/devkit";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      flake-parts,
      nixpkgs,
      treefmt-nix,
      devkit,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];

      imports = [
        inputs.flake-parts.flakeModules.easyOverlay
        treefmt-nix.flakeModule
      ];

      perSystem =
        { system, ... }:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              inputs.devkit.overlays.default
            ];
            config = {
              allowUnfree = true;
            };
          };

          devShell = name: devkit.devShells.${system}.${name};
        in
        {
          devShells = {
            default = pkgs.mkShell {
              name = "devkit";
              inputsFrom = [
                (devShell "node")
              ];
              packages = [ ];
            };
          };

          treefmt.config = {
            projectRootFile = "flake.nix";
            programs.nixfmt.enable = true;
            programs.prettier.enable = true;
            programs.shfmt.enable = true;
            programs.stylua.enable = true;
            programs.taplo.enable = true;
          };
        };
    };
}
