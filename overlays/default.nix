final: prev: {
  angular-language-server = prev.callPackage ./angular-language-server/package.nix {
    angular-language-server = prev.angular-language-server;
  };
  css-variables-language-server = prev.callPackage ./css-variables-language-server/package.nix { };
}
