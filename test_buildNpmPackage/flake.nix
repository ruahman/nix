{
  description = "Node.js development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
  let
    system = "x86_64-linux";  # or "aarch64-linux" if you're on ARM
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    packages.${system}.default = pkgs.buildNpmPackage {
      pname = "my-npm-package";
      version = "1.0.0";

      src = ./.;

      npmDepsHash = "sha256-7QyH1wBnotOs9EfH5upuwNxMi/t5Jy5Zrvza4WCSg9c=";

      dontNpmBuild = true;
    };
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [
        pkgs.nodejs
      ];
      shellHook = ''
        echo "Node.js $(node --version) environment"
      '';
    };
  };
}
