{
  description = "Up to date and cached packages for nightly versions of some tools";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixd.url = "github:nix-community/nixd";

    lix = {
      url = "git+https://git.lix.systems/lix-project/nixos-module";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim = {
      url = "github:neovim/neovim";
      flake = false;
    };

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
        {
          config,
          system,
          pkgs,
          ...
        }:
        {
          _module.args = {
            sources = inputs;
            pkgs = import inputs.nixpkgs {
              inherit system;
              config.allowUnfree = true;
            };
          };

          imports = [ ./packages ];
          overlayAttrs = config.packages;
          formatter = pkgs.nixfmt-rfc-style;
        };
    };
}
