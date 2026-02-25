{ pkgs }:

pkgs.mkShell {
  packages = [
    pkgs.nodejs
    pkgs.nodePackages."@angular/cli"
    pkgs.angular-language-server
  ];

  shellHook = /* bash */ ''
    export NG_CLI_ANALYTICS=false
    export NG_DISABLE_VERSION_CHECK=1
  '';
}
