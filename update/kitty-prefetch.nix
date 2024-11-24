{ sha256 }:
let
  flake = builtins.getFlake (toString ./..);
  pkgs = import flake.inputs.nixpkgs { };
in
flake.outputs.packages."${pkgs.system}".kitty.goModules.overrideAttrs (_: {
  vendorHash = sha256;
})
