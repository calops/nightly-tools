{
  pkgs,
  lib,
  config,
  ...
}:
{
  packages.kitty-nightly = pkgs.callPackage ./kitty.nix { };

  packages.all = pkgs.symlinkJoin {
    name = "all";
    paths = builtins.attrValues (lib.filterAttrs (name: _: name != "all") config.packages);
  };
}
