{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  pname = "test_derivation";
  version = "1.0.0";

  src = ./.;

  buildInputs = [ pkgs.nodejs ];

  # Run the build process
  buildPhase = ''
    export HOME=$PWD
    npm install
    npm run build
  '';

  # Install phase
  installPhase = ''
    mkdir -p $out
    cp -r * $out/
  '';

  # Metadata
  meta = with pkgs.lib; {
    description = "My NPM Project from GitHub";
    homepage = "https://github.com/github-username/github-repo-name";
    license = licenses.mit;
    platforms = platforms.all;
  };
}

