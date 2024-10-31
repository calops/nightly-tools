#! /usr/bin/env bash

set -e
set -x

function pre-update() {
	kitty-pre-update
}

function update() {
	nix flake update
}

function post-update() {
	kitty-post-update
}

# Kitty vendorHash requires some manual intervention
function get_kitty_vendor_hash() {
	nix run nixpkgs#nix-prefetch -- --option extra-experimental-features flakes "$(cat ./kitty-prefetch.nix)"
}

function kitty-pre-update() {
	OLD_VENDOR_HASH=$(sed -n 's|.*vendorHash = "\(.*\)";.*|\1|p' packages/kitty.nix)
}

function kitty-post-update() {
	NEW_VENDOR_HASH=$(get_kitty_vendor_hash)
	sed -i "s|${OLD_VENDOR_HASH}|${NEW_VENDOR_HASH}|" packages/kitty.nix
}

pre-update
update
post-update
