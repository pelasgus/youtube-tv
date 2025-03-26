# rust.nix
# Author: D.A.Pelasgus

let
  # Unstable Channel | Rolling Release
  pkgs = import (fetchTarball("channel:nixpkgs-unstable")) { 
    config.allowUnfree = true; # Allow unfree packages
  };

  packages = with pkgs; [
    cargo
    gdk-pixbuf
    glib
    glib.dev
    gst_all_1.gst-libav
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-good
    gst_all_1.gstreamer
    libavif
    libgcc
    libjack2
    libsoup_3
    pkg-config
    rust-analyzer
    rustc
    rustfmt
    trunk
    udev
    webkitgtk_4_1
    widevine-cdm
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
