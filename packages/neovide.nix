# Not actually nightly, but compiled with nightly neovim
{
  pkgs,
  neovim,
}:
pkgs.neovide.overrideAttrs {
  inherit neovim;
  name = "neovide-nightly";
  doCheck = false;
}
