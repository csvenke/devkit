{ pkgs }:

pkgs.mkShell {
  packages = [
    pkgs.playwright
    pkgs.playwright-driver.browsers
  ];

  shellHook = /* bash */ ''
    export PLAYWRIGHT_BROWSERS_PATH="${pkgs.playwright-driver.browsers}"
    export PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1
  '';
}
