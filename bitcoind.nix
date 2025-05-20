{
  gcc13Stdenv
, fetchurl
# build-inputs
, pkg-config
, cmake
, hexdump
, which
#
, url
, sha256
, depends
}:

gcc13Stdenv.mkDerivation rec {
  pname = "bitcoind";
  name = "bitcoind";
  src = fetchurl { inherit url sha256; };

  nativeBuildInputs = [ pkg-config cmake hexdump which ];
  buildInputs = [ ];
  cmakeFlags = [
    "-DCMAKE_TOOLCHAIN_FILE=${depends}/x86_64-pc-linux-gnu/toolchain.cmake"
  ];
  preFixup = ''
    ./contrib/devtools/split-debug.sh $out/bin/bitcoind $out/bin/bitcoind-s $out/bin/bitcoind-d
  '';

  dontStrip = true;
  doCheck = false;
  enableParallelBuilding = true;
}
