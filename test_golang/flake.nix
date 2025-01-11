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
      # test_golang = pkgs.buildGoModule {
      #   pname = "test_golang";
      #   version = "0.1.0";
      #
      #   src = ./.;
      #
      #   # Replace this with the actual hash after running `go mod vendor`
      #   # vendorHash = lib.fakeHash;
      #   vendorHash = "sha256-0zkcOYO72U2sLaah6OxrFgpye2VKsz1fumibLMtVsQg";
      #
      #   # Optional: LDFLAGS for stripping debug symbols
      #   ldflags = [ "-s" "-w" ];
      # };

    in {

      # packages.${system}.default = test_golang;
      packages.${system}.default = pkgs.buildGoModule {
        pname = "test_golang";
        version = "0.1.0";

        src = ./.;

        # Replace this with the actual hash after running `go mod vendor`
        # vendorHash = lib.fakeHash;
        vendorHash = "sha256-0zkcOYO72U2sLaah6OxrFgpye2VKsz1fumibLMtVsQg";

        # Optional: LDFLAGS for stripping debug symbols
        ldflags = [ "-s" "-w" ];
      };

      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          go
          gopls  # Go language server for editor support
          gotools  # Additional Go tools
          delve  # Go debugger
        ];
      };


      # apps are used to define applications that can be run directly using nix run
      # For example, if you define an app in your flake, you can execute it with nix run .#my-app.
      apps.${system}.default = {
        type = "app";
        program = "${self.packages.${system}.default}/bin/test_golang";
      };
    };
}
