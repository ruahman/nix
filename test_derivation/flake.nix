{
  description = "A very basic flake with npm project derivation";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      test_derivation = import ./default.nix { pkgs = pkgs; };
    in
    {
      # Define a package for the npm project
      packages.${system} = {
        inherit test_derivation;
        default = test_derivation;
      };

       # Add a devShell for development
      devShells.${system}.default = pkgs.mkShell {
        name = "npm-project-shell";

        buildInputs = [
          pkgs.nodejs
          test_derivation
        ];

        test_derivation = test_derivation;

        shellHook = ''
          echo "Welcome to the npm project development shell!"
          echo "Node version: $(node -v)"
          echo "NPM version: $(npm -v)"
          echo "test_derivation: $test_derivation"
        '';
      };
    };
}

