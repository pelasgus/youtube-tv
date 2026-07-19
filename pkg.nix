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
    pkgs.openssl
    pkgs.gobject-introspection
    pkgs.gtk3
    pkgs.librsvg
    pkgs.wrapGAppsHook4
  ];

  # Expose the package as an output for testing
  outputs = {
    inherit youtube-tv;
  };
  env.GIO_MODULE_DIR = "${pkgs.glib-networking}/lib/gio/modules/";
  # env.GSTREAMER_HELPERS_DIR = "${pkgs.gst_all_1}/lib/gst_all_1/";
  # env.GSTREAMER_PLUGINS_DIR = "${pkgs.gst_all_1}/lib/gst_all_1.gstreamer/gstreamer-1.0";
  # env.GST_PLUGIN_SYSTEM_PATH_1_0 = "${pkgs.gst_all_1.gstreamer.out}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-base}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-good}/lib/gstreamer-1.0";
  # env.GST_PLUGIN_PATH = "/run/current-system/sw/lib/gstreamer-1.0/";
  env.GST_PLUGIN_SYSTEM_PATH_1_0 = "${pkgs.gst_all_1.gstreamer.out}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-base}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-good}/lib/gstreamer-1.0";
  env.PATH = "$PATH:${pkgs.gst_all_1.gstreamer.dev}/bin";
}
