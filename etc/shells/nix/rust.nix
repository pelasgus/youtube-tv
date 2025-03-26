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
    glib.dev
    gdk-pixbuf
    udev
    libsoup_3
    webkitgtk_4_1
    gst_all_1.gstreamer
    gst_all_1.gst-libav
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-good
  ];
in
pkgs.mkShell {
  buildInputs = packages;

  # Ensure Rust binaries and dependencies are in the PATH
  shellHook = ''
    export PATH="$HOME/.cargo/bin:$PATH"
    export PKG_CONFIG_PATH="${pkgs.glib}/lib/pkgconfig:$PKG_CONFIG_PATH"
    
  '';
}
