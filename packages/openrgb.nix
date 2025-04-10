{ openrgb-with-all-plugins, src }:
openrgb-with-all-plugins.overrideAttrs (super: {
  inherit src;

  version = "nightly";
  name = "${super.pname}-nightly";

  # remove obsolete chmod substitution
  postPatch = ''
    patchShebangs scripts/build-udev-rules.sh
  '';
})
