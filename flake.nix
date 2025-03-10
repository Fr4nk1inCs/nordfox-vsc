{
  description = "A simple flake for VSCode theme development";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    hooks.url = "github:cachix/git-hooks.nix";

    utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    utils,
    hooks,
    ...
  }:
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
        checks = {
          pre-commit = hooks.lib.${system}.run {
            src = ./.;

            hooks = {
              commitizen.enable = true;
              prettier.enable = true;
            };
          };
        };
        devShells.default = pkgs.mkShell {
          name = "nordfox-vsc";

          inherit (self.checks.${system}.pre-commit) shellHook;
          packages = with pkgs;
            [
              nodejs
              pnpm
            ]
            ++ self.checks.${system}.pre-commit.enabledPackages;
        };
      }
    );
}


