{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    devkit = {
      url = "github:csvenke/devkit";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      flake-parts,
      nixpkgs,
      devkit,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;
      perSystem =
        { pkgs, system, ... }:
        let
          devShell = name: devkit.devShells.${system}.${name};
        in
        {
          devShells = {
            default = pkgs.mkShell {
              name = "devkit";
              inputsFrom = [
                (devShell "node")
              ];
              packages = with pkgs; [
                lolcat
                figlet
              ];
              shellHook = ''
                figlet "Devkit" | lolcat
              '';
            };
          };
        };
    };
}
