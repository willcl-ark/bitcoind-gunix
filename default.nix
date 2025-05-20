{ pkgs ? import <nixpkgs> {} }:

let
  version = "9a887baadebce7c2e76df831fad54c5fa81d309e";
  url = "https://github.com/bitcoin/bitcoin/archive/${version}.tar.gz";
  sha256 = "sha256-mbXamzOOXrL6AVc3wgt93KfijFghX/DMLyHjusuMcNQ=";

  depends = pkgs.callPackage ./depends.nix { inherit version url sha256; };
  bitcoind = pkgs.callPackage ./bitcoind.nix { inherit url sha256 depends; };
in {
  depends = depends;
  bitcoind = bitcoind;
}
