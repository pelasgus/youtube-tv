# default.nix
# Author: D.A.Pelasgus

{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage {
  pname = "youtube-tv";
  version = "0.1.0";

  src = ./.;  

  cargoLock = {
    lockFile = ./Cargo.lock;
  };

  meta = with pkgs.lib; {
    description = "YouTube on TV | Cross-platform HTPC Leanback Launcher.";
    license = licenses.gpl3;
    maintainers = with maintainers; [D.A.Pelasgus ];
  };
}
