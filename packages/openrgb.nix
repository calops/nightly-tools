{
  openrgb-with-all-plugins,
  coreutils,
  src,
}:
openrgb-with-all-plugins.overrideAttrs (super: {
  inherit src;

  version = "nightly";
  name = "${super.pname}-nightly";

  # remove obsolete chmod substitution
  postPatch = ''
    patchShebangs scripts/build-udev-rules.sh
    substituteInPlace scripts/build-udev-rules.sh --replace-fail /usr/bin/env "${coreutils}/bin/env"
  '';
})
