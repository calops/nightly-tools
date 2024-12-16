{
  pkgs,
  lib,
  config,
  sources,
  ...
}:
let
  neovim = sources.neovim-nightly-overlay.packages."${pkgs.system}".neovim;
in
{
  packages = {
    # FIXME: kitty build is broken for now
    # kitty = pkgs.callPackage ./kitty.nix { inherit sources; };
    inherit neovim;
    neovide = pkgs.callPackage ./neovide.nix { inherit (config.packages) neovim; };
    nixd = sources.nixd.packages."${pkgs.system}".nixd;
    lix = sources.lix.packages."${pkgs.system}".default;
  };

  packages.all = pkgs.symlinkJoin {
    name = "all";
    paths = builtins.attrValues (lib.filterAttrs (name: _: name != "all") config.packages);
  };
}
