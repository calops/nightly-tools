#! /usr/bin/env bash

set -e
set -x

nix run nixpkgs#niv update
