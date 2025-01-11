{
  description = "Your C Project using Nix Flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
    let
      # Specify the system for which you're building
      system = "x86_64-linux";  # or "aarch64-linux", "x86_64-darwin", etc.
      pkgs = import nixpkgs {
        inherit system;
      };
    in {
      packages.${system}.default = pkgs.stdenv.mkDerivation rec {
        name = "hello-world";
        version = "1.0.0";

        # Source directory relative to this file
        src = ./.;

        # If your project uses a Makefile, this is how you would use it
        # If not, you'd need to specify custom build phases
        # makeFlags = [
        #   "PREFIX=$(out)"
        # ];

        # Custom build phases if you're not using a Makefile
        buildPhase = ''
          gcc -o hello-world main.c
        '';

        # Install phase if not using Makefile
        installPhase = ''
          mkdir -p $out/bin
          cp hello-world $out/bin/
        '';

        # If you're using a Makefile, installation might be handled there
        # installFlags = [ "PREFIX=$(out)" ];

        # Metadata about the package
        meta = with pkgs.lib; {
          description = "Description of your C project";
          license = licenses.mit;
          platforms = platforms.all;
        };

        # This is for any runtime dependencies your project might have
        buildInputs = [
          # Add any C libraries or tools your project needs here
          # e.g., pkgs.zlib, pkgs.openssl, etc.
        ];
      };

      # Optional: Define a development shell
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          pkgs.gcc
          # Add any other development tools or libraries here
        ];
      };
    };
}
