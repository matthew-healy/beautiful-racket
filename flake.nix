{
  description = "Beautiful Racket book";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = {self, nixpkgs, utils}:
    utils.lib.eachDefaultSystem(system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = [ pkgs.racket ];
        };

        formatter = pkgs.nixfmt-rfc-style;
      }
  );
}
