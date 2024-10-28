{
  description = "Up to date and cached packages for nightly versions of some tools";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
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
        { config, ... }:
        {
          imports = [ ./packages ];
          overlayAttrs = config.packages;
        };
      flake = {
        # formatter = inputs.pkgs.nixfmt-rfc-style; FIXME
      };
    };
}
