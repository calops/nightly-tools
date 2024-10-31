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
    kitty = pkgs.callPackage ./kitty.nix { inherit sources; };
    neovide = pkgs.callPackage ./neovide.nix {
      inherit sources;
      inherit neovim;
    };
  };

  packages.all = pkgs.symlinkJoin {
    name = "all";
    paths = builtins.attrValues (lib.filterAttrs (name: _: name != "all") config.packages);
  };
}
