{
  description = "Up to date and cached packages for nightly versions of some tools";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixd.url = "github:nix-community/nixd";

    kitty = {
      url = "github:kovidgoyal/kitty";
      flake = false;
    };
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
          _module.args = {
            sources = inputs;
          };

          imports = [ ./packages ];
          overlayAttrs = config.packages;
        };

      flake = {
        # formatter = inputs.pkgs.nixfmt-rfc-style; FIXME
      };
    };
}
