let
  # Unstable Channel | Rolling Release
  pkgs = import (fetchTarball("channel:nixpkgs-unstable")) { };

  packages = with pkgs; [
    pkg-config
    rustc
    cargo
    rustfmt
    rust-analyzer
    webkitgtk_4_1
  ];
in
pkgs.mkShell {
  buildInputs = packages;
}