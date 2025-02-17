{
  pkgs,
  lix,
}:
lix.packages."${pkgs.system}".default.overrideAttrs {
  doCheck = false;
}
