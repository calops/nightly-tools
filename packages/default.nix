{
  pkgs,
  lib,
  sources,
  ...
}:
let
  packages =
    rec {
      neovim = sources.neovim-nightly-overlay.packages."${pkgs.system}".neovim;
      neovide = pkgs.callPackage ./neovide.nix { inherit neovim; };
      nixd = sources.nixd.packages."${pkgs.system}".nixd;
      lix = sources.lix.packages."${pkgs.system}".default;
      cadquery = sources.cadquery.packages."${pkgs.system}".cadquery;
      cq-editor = sources.cadquery.packages."${pkgs.system}".cq-editor;
    }
    // (lib.optionalAttrs pkgs.stdenv.isLinux {
      niri = pkgs.callPackage ./niri.nix { inherit (sources) niri; };
    });

  all = pkgs.symlinkJoin {
    name = "all";
    paths = builtins.attrValues packages;
  };
in
{
  packages = packages // {
    inherit all;
  };
}
