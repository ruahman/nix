{
  description = "A Go project for Linux x86_64";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
      lib = nixpkgs.lib;

      # Define the Go project
      my-go-project = pkgs.buildGoModule {
        pname = "my-go-project";
        version = "0.1.0";

        src = ./.;

        # Replace this with the actual hash after running `go mod vendor`
        vendorHash = lib.fakeSha256;

        # Optional: LDFLAGS for stripping debug symbols
        ldflags = [ "-s" "-w" ];
      };

    in {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          go
          gopls  # Go language server for editor support
          gotools  # Additional Go tools
          delve  # Go debugger
        ];
      };

      packages.${system}.default = my-go-project;

      # apps are used to define applications that can be run directly using nix run
      # For example, if you define an app in your flake, you can execute it with nix run .#my-app.
      apps.${system}.default = {
        type = "app";
        program = "${my-go-project}/bin/my-go-project";
      };
    };
}
