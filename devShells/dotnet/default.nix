{ pkgs }:

let
  dotnet =
    with pkgs.dotnetCorePackages;
    (combinePackages [
      sdk_8_0
      sdk_9_0
    ]);
in

pkgs.mkShell {
  packages = [
    dotnet
    pkgs.csharpier
    pkgs.omnisharp-roslyn
    pkgs.netcoredbg
  ];
  shellHook = ''
    export DOTNET_ROOT=${dotnet}
  '';
}
