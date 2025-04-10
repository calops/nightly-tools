{ openrgb-with-all-plugins, src }:
openrgb-with-all-plugins.overrideAttrs (super: {
  version = "nightly";
  name = "${super.name}-nightly";
  inherit src;
})
