{ pkgs }:

pkgs.mkShell {
  packages = [
    pkgs.nodePackages."@angular/cli"
    pkgs.angular-language-server
  ];
}
