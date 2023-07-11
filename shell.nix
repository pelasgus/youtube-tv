let
  pkgs = import <nixpkgs> { };

  libraries = with pkgs;[
    webkitgtk
    gtk3
    cairo
    gdk-pixbuf
    glib
    dbus
    openssl_3
  ];

  packages = with pkgs; [
    pkg-config
    dbus
    openssl_3
    glib
    gtk3
    libsoup
    webkitgtk
    appimagekit
  ];
in
pkgs.mkShell {
  buildInputs = packages;

  shellHook =
    ''
      export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath libraries}:$LD_LIBRARY_PATH
    '';
}