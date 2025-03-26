# rust.nix
# Author: D.A.Pelasgus

let
  # Unstable Channel | Rolling Release
  pkgs = import (fetchTarball("channel:nixpkgs-unstable")) { };
  packages = with pkgs; [
    pkg-config
    rustc
    cargo
    rustfmt
    rust-analyzer
    trunk
    glib
    gdk-pixbuf
    libsoup_3
    atkmm
    webkitgtk_4_1
  ];
in
pkgs.mkShell {
  buildInputs = packages;

  # Ensure Rust binaries and dependencies are in the PATH
  shellHook = ''
    export PATH="$HOME/.cargo/bin:$PATH"
  '';
}
