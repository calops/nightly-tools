{
  pkgs,
  niri,
}:
niri.packages."${pkgs.system}".niri-unstable.overrideAttrs {
  doCheck = false;
}
