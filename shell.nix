with import <nixpkgs> {};
stdenv.mkDerivation rec {
  name = "env";
  env = buildEnv { name = name; paths = buildInputs; };
  buildInputs = [
    python
    python37Packages.virtualenv
    python37Packages.pip
    python37Packages.setuptools
    python37Packages.shapely
    python37Packages.scrapy
    python37Packages.scipy
    python37Packages.matplotlib
    python37Packages.numpy
    python37Packages.geopandas
    python37Packages.click
    python37Packages.click-log
    python37Packages.cffi
    python37Packages.pyyaml
    mongodb-compass
  ];
}
