{
  description = "Up to date and cached packages for nightly versions of some tools";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixd = {
      url = "github:nix-community/nixd";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nh = {
      url = "github:viperML/nh";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:calops/niri-flake/";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.niri-unstable.follows = "niri-src";
    };

    niri-src = {
      url = "github:yalter/niri";
    };

    devenv = {
      url = "github:cachix/devenv";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
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
