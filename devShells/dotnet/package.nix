{ pkgs }:

let
  dotnet =
    with pkgs.dotnetCorePackages;
    combinePackages [
      sdk_8_0
      sdk_9_0
      sdk_10_0
      sdk_11_0
    ];
in

pkgs.mkShell {
  packages = [
    dotnet
    pkgs.netcoredbg
    pkgs.csharpier
    pkgs.dotnet-ef
  ];

  shellHook = /* bash */ ''
    export DOTNET_ROOT="${dotnet}/share/dotnet"
  '';
}
