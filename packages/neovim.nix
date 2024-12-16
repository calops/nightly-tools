{ pkgs, sources, ... }:
sources.neovim-nightly-overlay.packages."${pkgs.system}".neovim.overrideAttrs {
  src = sources.neovim;
}
