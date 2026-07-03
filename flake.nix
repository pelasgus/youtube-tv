{
  inputs.flake-parts.url = "github:hercules-ci/flake-parts";
  inputs.devenv.url = "github:cachix/devenv";
  inputs.nixpkgs.url = "github:cachix/devenv-nixpkgs/rolling";
  inputs.crate2nix.url = "github:nix-community/crate2nix";
  inputs.crate2nix.inputs.nixpkgs.follows = "nixpkgs";

  outputs =
    inputs@{ flake-parts, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.devenv.flakeModule
      ];
      systems = nixpkgs.lib.systems.flakeExposed;

      perSystem =
        {
          config,
          self',
          inputs',
          pkgs,
          system,
          ...
        }:
        {
          # Per-system attributes can be defined here. The self' and inputs'
          # module parameters provide easy access to attributes of the same
          # system.
          # packages.default = youtube-tv;

          # Equivalent to  inputs'.nixpkgs.legacyPackages.hello;
          devenv.shells.default = {
            imports = [
              ./rust.nix
            ];
            # https://devenv.sh/reference/options/

            enterShell = ''
              youtube-tv
            '';
          };
        };
    };
}
