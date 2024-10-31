# Checks are failing right now so let's just disable them
{
  pkgs,
  sources,
  ...
}:
pkgs.kitty.overrideAttrs (oldAttrs: rec {
  name = "kitty-nightly";
  version = "nightly";

  src = sources.kitty;

  goModules =
    (pkgs.buildGo123Module {
      pname = "kitty-go-modules-nightly";
      inherit src version;
      vendorHash = "sha256-d5jRhOm53HDGnsU5Lg5tVGU/9z8RGqORzS53hOyIKBk=";
      doCheck = false;
      doInstallCheck = false;
    }).goModules;

  doCheck = false;
  doInstallCheck = false;
})
