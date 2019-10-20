with import <nixpkgs> {};

let
  hypercorn = python37.pkgs.buildPythonPackage rec {
    pname = "Hypercorn";
    version = "0.9.0";

    src = python37.pkgs.fetchPypi {
      inherit pname version;
      sha256 = "102l3bl2r1ij1k5hiwg36bffbv7301b1jv9ifcw11f6daw6qip78";
    };

    doCheck = false;
    propagatedBuildInputs = with python37Packages; [
      priority
      h2
      toml
      wsproto
      typing-extensions
      h11
      ];
    meta = {
      homepage = "https://gitlab.com/pgjones/hypercorn/";
      description = "Hypercorn is an ASGI Server based on Hyper libraries and inspired by Gunicorn.";
    };
  };
  quart = python37.pkgs.buildPythonPackage rec {
    pname = "Quart";
    version = "0.10.0";

    src = python37.pkgs.fetchPypi {
      inherit pname version;
      sha256 = "00q776p2c4slsziazhs9fi6gkyy13phxdp7j5z1qf7q3jb1z4afk";
    };

    doCheck = false;
    propagatedBuildInputs = with python37Packages; [
      hypercorn
      click
      itsdangerous
      multidict
      sortedcontainers
        blinker
        jinja2
        aiofiles
      ];
    meta = {
      homepage = "https://gitlab.com/pgjones/quart";
      description = "Quart is a Python ASGI web microframework.";
    };
  };
  quart_cors = python37.pkgs.buildPythonPackage rec {
    pname = "Quart-CORS";
    version = "0.2.0";

    src = python37.pkgs.fetchPypi {
      inherit pname version;
      sha256 = "15s2ldsxwfw65cmksfyv64jvmkgk2xac8xs64v4ljhjn7gp7z7iv";
    };

    doCheck = false;
    propagatedBuildInputs = with python37Packages; [
      quart
      ];
    meta = {
      homepage = "https://gitlab.com/pgjones/quart";
      description = "Quart is a Python ASGI web microframework.";
    };
  };
in
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
      quart
      quart_cors
    ];
  }
