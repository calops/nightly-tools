{
  description = "Up to date and cached packages for nightly versions of some tools";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake
      {
        inputs = inputs // {
          nixpkgs = (import ./nix/sources.nix).nixpkgs;
        };
      }
      {
        imports = [
          inputs.flake-parts.flakeModules.easyOverlay
        ];

        systems = [
          "x86_64-linux"
          "aarch64-linux"
          "aarch64-darwin"
          "x86_64-darwin"
        ];

        perSystem =
          { config, system, ... }:
          {
            _module.args = rec {
              sources = import ./nix/sources.nix;
              pkgs = (import sources.nixpkgs { inherit system; });
            };

            imports = [ ./packages ];
            overlayAttrs = config.packages;
          };

        flake = {
          # formatter = inputs.pkgs.nixfmt-rfc-style; FIXME
        };
      };
}
