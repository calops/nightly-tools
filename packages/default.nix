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
    inherit neovim;
    # FIXME: kitty build is broken for now
    # kitty = pkgs.callPackage ./kitty.nix { inherit sources; };
    neovide = pkgs.callPackage ./neovide.nix { inherit neovim; };
    nixd = sources.nixd.packages."${pkgs.system}".nixd;
    steam-tui = pkgs.steam-tui;
    lix = sources.lix.packages."${pkgs.system}".default;
  };

  packages.all = pkgs.symlinkJoin {
    name = "all";
    paths = builtins.attrValues (lib.filterAttrs (name: _: name != "all") config.packages);
  };
}
