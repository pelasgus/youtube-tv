{ config, pkgs, ... }:
let
  youtube-tv = config.languages.rust.import ./app { };
in
{
  packages = [
    # Include the imported package in the environment
    youtube-tv
    # Deps
    pkgs.gst_all_1.gst-libav
    pkgs.gst_all_1.gst-plugins-bad
    pkgs.gst_all_1.gst-plugins-good
    pkgs.gst_all_1.gstreamer
    pkgs.gst_all_1.gst-plugins-base
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
  env.GIO_MODULE_DIR = "${pkgs.glib-networking}/lib/gio/modules/";
}
