{
  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  outputs = {self, nixpkgs}: let
    arch = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${arch};
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
      # widevine-cdm
    ];
  in {
    packages.${arch}.default = pkgs.rustPlatform.buildRustPackage {
      name = "Youtube-TV";
      src = ./.;
      buildInputs = packages;
      nativeBuildInputs = [pkgs.pkg-config];
      cargoLock.lockFile = ./Cargo.lock;
    # cargoHash =  pkgs.lib.fakeHash;
    };
  }; 
}
