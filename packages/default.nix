{
  pkgs,
  lib,
  config,
  sources,
  ...
}:
{
  packages.kitty = pkgs.callPackage ./kitty.nix { inherit sources; };

  packages.all = pkgs.symlinkJoin {
    name = "all";
    paths = builtins.attrValues (lib.filterAttrs (name: _: name != "all") config.packages);
  };
}
