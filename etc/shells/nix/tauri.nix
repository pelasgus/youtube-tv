# tauri.nix
# Author: D.A.Pelasgus
# Follows https://tauri.app/start/prerequisites/#tab-panel-1343 but on unstable.\

let
  # Unstable Channel | Rolling Release
  pkgs = import (fetchTarball("channel:nixpkgs-unstable")) { };
in
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    pkg-config
    gobject-introspection
    cargo
    cargo-tauri
    nodejs
  ];

  buildInputs = with pkgs;[
    at-spi2-atk
    atkmm
    cairo
    gdk-pixbuf
    glib
    gtk3
    harfbuzz
    librsvg
    libsoup_3
    pango
    webkitgtk_4_1
    openssl
  ];
}  
