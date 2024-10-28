{ pkgs, ... }:
{
  packages.kitty-nightly = pkgs.kitty.overrideAttrs (oldAttrs: rec {
    name = "kitty-nightly";
    version = "nightly";

    src = pkgs.fetchFromGitHub {
      owner = "kovidgoyal";
      repo = "kitty";
      rev = "8b7cd98a0eb482a5fa26daef90be7db5fd1be64d";
      sha256 = "sha256-ze28vZJFjTTCZHoGoNvW9GZVY45EnOTPlTwR11Z5NYo=";
    };

    goModules =
      (pkgs.buildGo123Module {
        pname = "kitty-go-modules";
        inherit src version;
        vendorHash = "sha256-d5jRhOm53HDGnsU5Lg5tVGU/9z8RGqORzS53hOyIKBk=";
        doCheck = false;
        doInstallCheck = false;
      }).goModules;

    doCheck = false;
    doInstallCheck = false;
  });
}
