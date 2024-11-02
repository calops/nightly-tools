# Not actually nightly, but compiled with nightly neovim
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
