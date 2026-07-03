# https://devenv.sh/languages/rust/
{ config, pkgs, ... }:
let
  youtube-tv = config.languages.rust.import ./app { };
in
{
  languages.rust.enable = true;

  # Include the imported package in the environment
  packages = [
    youtube-tv
    pkgs.gst_all_1.gst-libav
    pkgs.gst_all_1.gst-plugins-bad
    pkgs.gst_all_1.gst-plugins-good
    pkgs.gst_all_1.gstreamer
    # pkgs.widevine-cdm
    pkgs.gdk-pixbuf
    pkgs.glib.dev
    pkgs.libavif
    pkgs.libgcc
    pkgs.libjack2
    pkgs.libsoup_3
    pkgs.pkg-config
    pkgs.trunk
    pkgs.udev
    pkgs.webkitgtk_4_1
    pkgs.glib-networking
  ];

  # Expose the package as an output for testing
  outputs = {
    inherit youtube-tv;
  };

  git-hooks.hooks = {
    rustfmt.enable = true;
    clippy.enable = true;
  };
}
