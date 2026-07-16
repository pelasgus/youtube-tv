{ config, pkgs, lib, ... }:

let
  youtube-tv = (config.languages.rust.import ./app { }).overrideAttrs (old: {
    nativeBuildInputs = (old.nativeBuildInputs or []) ++ [
      pkgs.makeWrapper
    ];

    postInstall = (old.postInstall or "") + ''
      wrapProgram $out/bin/youtube-tv \
        --prefix GST_PLUGIN_SYSTEM_PATH_1_0 : "${
          lib.makeSearchPath "lib/gstreamer-1.0" [
            pkgs.gst_all_1.gstreamer
            pkgs.gst_all_1.gst-plugins-base
            (pkgs.gst_all_1.gst-plugins-good.override { gtkSupport = true; })
            pkgs.gst_all_1.gst-plugins-bad
            pkgs.gst_all_1.gst-plugins-ugly
            pkgs.gst_all_1.gst-libav
            pkgs.gst_all_1.gst-vaapi
          ]
        }"
    '';
  });
in
{
  packages = [
    youtube-tv

    # GStreamer
    pkgs.gst_all_1.gstreamer
    pkgs.gst_all_1.gst-plugins-base
    (pkgs.gst_all_1.gst-plugins-good.override { gtkSupport = true; })
    pkgs.gst_all_1.gst-plugins-bad
    pkgs.gst_all_1.gst-plugins-ugly
    pkgs.gst_all_1.gst-libav
    pkgs.gst_all_1.gst-vaapi

    # Other dependencies
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
  ];

  outputs = {
    inherit youtube-tv;
  };

  env.GIO_MODULE_DIR = "${pkgs.glib-networking}/lib/gio/modules";
  env.PATH = "$PATH:${pkgs.gst_all_1.gstreamer.dev}/bin";
}
