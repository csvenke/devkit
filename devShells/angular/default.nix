{
  mkShell,
  nodePackages,
  angular-language-server,
}:

mkShell {
  packages = [
    nodePackages."@angular/cli"
    angular-language-server
  ];
}
