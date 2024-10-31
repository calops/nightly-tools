#! /usr/bin/env bash

set -e
set -x

nix run nixpkgs#niv -- update

# Kitty vendorHash requires some manual intervention
VENDOR_HASH=$(nix run nixpkgs#nix-prefetch -- "{ sha256 }: pkgs.kitty.goModules.overrideAttrs (_: { vendorHash = sha256; })" --option extra-experimental-features flakes)
OLD_HASH=$(jq -r '.kitty.vendorHash' nix/sources.json)

sed -i "s|${OLD_HASH}|${VENDOR_HASH}|" nix/sources.json
