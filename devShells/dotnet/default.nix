{ pkgs }:

let
  dotnet = with pkgs.dotnetCorePackages; (combinePackages [
    sdk_7_0
    sdk_8_0
    sdk_9_0
  ]);
in

pkgs.mkShell {
  packages = with pkgs; [
    dotnet
    csharpier
    omnisharp-roslyn
  ];
  shellHook = ''
    export DOTNET_ROOT=${dotnet}
  '';
}
