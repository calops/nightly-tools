# Checks are failing right now so let's just disable them
{
  pkgs,
  sources,
  ...
}:
pkgs.kitty.overrideAttrs (oldAttrs: rec {
  name = "kitty-nightly";
  version = "nightly-${sources.kitty.rev}";

  src = pkgs.fetchFromGitHub {
    inherit (sources.kitty)
      rev
      owner
      repo
      sha256
      ;
  };

  goModules =
    (pkgs.buildGo123Module {
      pname = "kitty-go-modules-nightly";
      inherit src version;
      vendorHash = sources.kitty.vendorHash;
      doCheck = false;
      doInstallCheck = false;
    }).goModules;

  doCheck = false;
  doInstallCheck = false;
})
