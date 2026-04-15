{ pkgs }:

pkgs.mkShell {
  packages = [
    pkgs.nodejs
    pkgs.nodePackages."@angular/cli"
  ];

  shellHook = /* bash */ ''
    export NG_CLI_ANALYTICS=false
    export NG_DISABLE_VERSION_CHECK=1
  '';
}
