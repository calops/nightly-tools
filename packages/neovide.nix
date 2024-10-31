# Checks are failing right now so let's just disable them
{
  pkgs,
  neovim,
  ...
}:
pkgs.neovide.overrideAttrs (oldAttrs: {
  inherit neovim;
  name = "neovide-nightly";
  version = "nightly";
})
