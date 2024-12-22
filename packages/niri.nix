{
  pkgs,
  niri,
}:
niri.packages."${pkgs.system}".niri-unstable
