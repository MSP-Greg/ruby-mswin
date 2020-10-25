# ruby_mswin

## Introduction

This repo contains code to create, test and store stand-alone Ruby mswin builds.  The builds
are stored in the repo's releases(s).  At present they are in the release
[Ruby mswin builds](https://github.com/MSP-Greg/ruby-mswin/releases/tag/ruby-mswin-builds).

Each 7z archive is named with the full Ruby version, the root folder is
`Ruby<M><m>-ms`, where M and m are the digits from the major and minor portion of the
version (M.m.p).  At present, major and minor portions have never exceeded a single digit.

An example is the `Ruby-3.1.2-ms.7z` file, with a root folder of `Ruby31-ms`.  This allows
one to install new Ruby patch releases (eg 3.1.3) without code changes.

The dependencies (libffi, libyaml, openssl, readline-win32, zlib) are built with the
[microsoft/vcpkg](https://github.com/Microsoft/vcpkg) system.  The code that creates and
stores them is in [ruby/setup-msys2-gcc](https://github.com/ruby/setup-msys2-gcc).

All dependency dll's are packaged with the archives, just like almost all publicly available
Ruby builds.

If one needs to compile extension gems, one will need MSVC tools and possibly
packages installed in an microsoft/vcpkg install.

`RbConfig::CONFIG['configure_args']` contains `--with-opt-dir=C:/vcpkg/installed/x64-windows`,
so that is the default location for microsoft/vcpkg.

This repo willl just contain Ruby release builds.  It is based on the code in
[ruby-loco](https://github.com/MSP-Greg/ruby-loco), which creates and stores mingw, ucrt,
& mswin Ruby master builds.  They can be downloaded from a ruby-loco
[release](https://github.com/MSP-Greg/ruby-loco/releases/tag/ruby-master).

## OpenSSL Configuration

The [microsoft/vcpkg OpenSSL package](https://github.com/microsoft/vcpkg/tree/master/ports/openssl)
sets the following:

```
OpenSSL::X509::DEFAULT_CERT_FILE      C:/vcpkg/packages/openssl_x64-windows/cert.pem
OpenSSL::X509::DEFAULT_CERT_DIR       C:/vcpkg/packages/openssl_x64-windows/certs
OpenSSL::Config::DEFAULT_CONFIG_FILE  C:/vcpkg/packages/openssl_x64-windows/openssl.cnf
```

The files/directory needed are included in the Ruby build, one can either copy them to the above
locations, or set the following ENV variables:

```
ENV['SSL_CERT_FILE'] = <Ruby root dir>/ssl/cert.pem
ENV['SSL_CERT_DIR']  = <Ruby root dir>/ssl/certs
ENV['OPENSSL_CONF']  = <Ruby root dir>/ssl/openssl.cnf
```

## Issues

Ruby 3.1 and earlier will not compile with Visual Studio 2022.  Ruby master (3.2) will.
This is due to an MSFT bug that was fixed in April-2022, but has not been included in a
release yet.

[microsoft/vcpkg's current OpenSSL package]((https://github.com/microsoft/vcpkg/tree/master/ports/openssl))
is version 3.0.5.  As of July-2022, Ruby 3.1 (and later) are the only Ruby versions that
are compatible with OpenSSL 3.  At present, there is not a repo to store old pre-built vcpkg
packages.  I may create a repo for that, as it will become an issue with builds in the future.
Having it (OpenSSL 1.1.1) would allow building Ruby 2.7 and 3.0.
