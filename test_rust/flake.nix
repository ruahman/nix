{
  description = "Your Rust Project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nixpkgs, rust-overlay }: 
    let
      system = "x86_64-linux";
      overlays = [ (import rust-overlay) ];
      pkgs = import nixpkgs {
        inherit system overlays;
      };

      rustVersion = pkgs.rust-bin.stable.latest.default;
      rustPlatform = pkgs.makeRustPlatform {
        cargo = rustVersion;
        rustc = rustVersion;
      };

    in rec {
      packages.${system}.default = rustPlatform.buildRustPackage {
        pname = "test_rust";
        version = "1.0.0";

        src = ./.;

        cargoHash = "sha256-XIY4j+hfPSP1ipApNRhF1qIs6T5aE6wzNRFkjnQmwWo";

        # Add any additional build inputs here if needed
        buildInputs = [ pkgs.openssl pkgs.pkg-config ];

        meta = with pkgs.lib; {
          description = "Description of your project";
          license = licenses.mit;
          maintainers = with maintainers; [ your-maintainer ];
          platforms = platforms.all;
        };
      };

      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          rustVersion
          pkgs.rustfmt
          pkgs.clippy
          # Add any other tools you need during development
        ];
      };

      apps.${system}.default = {
        type = "app";
        program = "${self.packages.${system}.default}/bin/test_rust";
      };
    };
}
