{
  pkgs,
  niri,
  niri-fork,
}:
niri.packages."${pkgs.system}".niri-unstable.overrideAttrs {
  src = niri-fork;
}
