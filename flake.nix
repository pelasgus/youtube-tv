{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    devenv.url = "github:cachix/devenv";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{ flake-parts, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.devenv.flakeModule
      ];
      systems = nixpkgs.lib.systems.flakeExposed;

      perSystem =
        {
          pkgs,
          system,
          config,
          ...
        }:
        let
          buildInputs = with pkgs; [
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
            glib-networking
            gobject-introspection
          ];
        in
        {
          packages.default = pkgs.rustPlatform.buildRustPackage {
            pname = "Youtube-TV";
            version = "0.1.0";

            src = ./.;

            inherit buildInputs;
            nativeBuildInputs = [ pkgs.pkg-config ];

            cargoLock.lockFile = ./Cargo.lock;
            # cargoHash = pkgs.lib.fakeHash;
          };

          devenv.shells.default = {
            # https://devenv.sh/reference/options/
            packages = [ config.packages.default ];

            enterShell = ''
              hello
            '';
          };
          devShells.default = pkgs.mkShell {
            inherit buildInputs;

            nativeBuildInputs = with pkgs; [
              pkg-config
            ];

            # https://github.com/NixOS/nixpkgs/issues/64530
            shellHook = ''
              export RUST_SRC_PATH=${pkgs.rustPlatform.rustLibSrc}
              export PATH="$HOME/.cargo/bin:$PATH"
              export PKG_CONFIG_PATH="${pkgs.glib}/lib/pkgconfig:$PKG_CONFIG_PATH"
              export GIO_MODULE_DIR="${pkgs.glib-networking}/lib/gio/modules/"
            '';
          };
        };
    };
}
