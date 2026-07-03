# https://devenv.sh/languages/rust/
{ config, ... }:
let
  youtube-tv = config.languages.rust.import ./app { };
in
{
  languages.rust.enable = true;

  # Include the imported package in the environment
  packages = [ youtube-tv ];

  # Expose the package as an output for testing
  outputs = {
    inherit youtube-tv;
  };

  git-hooks.hooks = {
    rustfmt.enable = true;
    clippy.enable = true;
  };
}
