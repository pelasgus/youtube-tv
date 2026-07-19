{ config, pkgs, ... }:
let
  youtube-tv = config.languages.rust.import ./app { };
in
{
  packages = [
    # Include the imported package in the environment
    youtube-tv
    # Deps
    # https://github.com/tauri-apps/tauri/issues/8579
    pkgs.gst_all_1.gst-libav
    pkgs.gst_all_1.gst-plugins-bad
    (pkgs.gst_all_1.gst-plugins-good.override { gtkSupport = true; }) # gtksink
    pkgs.gst_all_1.gstreamer
    pkgs.gst_all_1.gst-plugins-base
    pkgs.gst_all_1.gst-plugins-ugly
    pkgs.gst_all_1.gst-vaapi
    pkgs.widevine-cdm
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
    pkgs.wrapGAppsHook4
  ];

  # Expose the package as an output for testing
  outputs = {
    inherit youtube-tv;
  };
  env.GIO_MODULE_DIR = "${pkgs.glib-networking}/lib/gio/modules/";
}
