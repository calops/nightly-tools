{
  pkgs,
  lib,
  config,
  sources,
  ...
}:
{
  packages = {
    # FIXME: kitty build is broken for now
    # kitty = pkgs.callPackage ./kitty.nix { inherit sources; };
    neovim = pkgs.callPackage ./neovim.nix { inherit sources; };
    neovide = pkgs.callPackage ./neovide.nix { inherit (config.packages) neovim; };
    nixd = sources.nixd.packages."${pkgs.system}".nixd;
    lix = sources.lix.packages."${pkgs.system}".default;
  };

  packages.all = pkgs.symlinkJoin {
    name = "all";
    paths = builtins.attrValues (lib.filterAttrs (name: _: name != "all") config.packages);
  };
}
