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
      nh = sources.nh.packages."${pkgs.system}".default;
      lix = pkgs.callPackage ./lix.nix { inherit (sources) lix; };
      devenv = sources.devenv.packages."${pkgs.system}".devenv;
    }
    // (lib.optionalAttrs pkgs.stdenv.isLinux {
      niri = pkgs.callPackage ./niri.nix { inherit (sources) niri; };
      openrgb = pkgs.callPackage ./openrgb.nix { src = sources.openrgb-src; };
      quickshell = sources.quickshell.packages."${pkgs.system}".quickshell;
      anyrun = sources.anyrun.packages."${pkgs.system}".anyrun;
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
