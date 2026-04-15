{ pkgs }:

let
  dotnet =
    with pkgs.dotnetCorePackages;
    combinePackages [
      sdk_8_0
      sdk_9_0
      sdk_10_0
    ];
in

pkgs.mkShell {
  packages = [
    dotnet
    pkgs.inotify-tools
    pkgs.netcoredbg
    pkgs.csharpier
  ];

  shellHook = /* bash */ ''
    export DOTNET_ROOT="${dotnet}/share/dotnet"
  '';
}
