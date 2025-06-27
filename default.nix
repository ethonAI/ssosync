let
  pkgs = import (builtins.fetchTree {
    type = "git";
    url = "https://github.com/nixos/nixpkgs/";
    rev = "d74a2335ac9c133d6bbec9fc98d91a77f1604c1f"; # 17-02-2025
    shallow = true;
    # obtain via `git ls-remote https://github.com/nixos/nixpkgs nixos-unstable`
  }) { config = {}; };
in
rec {
  pname = "fillthis";
  version = "0.0.1";
  artifacts = {
    ssosync = pkgs.buildGoModule {
      pname = "ssosync";
      version = "e394fea5f1fc845d0d590347b6fb42406716fee8";
      src = ./.;
      vendorHash = "sha256-7px6+K+2byltj58l3vsK2FFAtslZvgLbZ9slfbJf9Uk=";
    };
  };
  shell = pkgs.mkShellNoCC {
    packages = with pkgs; [
      git
      gnumake

      artifacts.ssosync
      go

      gopls
    ];
  };
}
