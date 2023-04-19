Droptools
======================

This is fork of [benjamin-bader](https://github.com/benjamin-bader) fantastic Dropwizard-jOOQ linker.
I, [daberkow](https://github.com/daberkow/), forked it to add support for newer Dropwizard and jOOQ versions. I, have
patched the library to support Dropwizard 3.0/4.0 and Java 11+. I am not using `dropwizard-redis`, that has been patched
to pass builds, yet I can not promise any other operations.

[![Build Status](https://github.com/daberkow/droptools/actions/workflows/test.yml/badge.svg)](https://github.com/daberkow/droptools/actions/workflows/test.yml)

[Maven Central information](https://central.sonatype.com/artifact/co.ntbl.dropwizard/dropwizard-jooq/)

[`dropwizard-jooq`](docs/jooq.md)
-----------------

A bundle that adds support for relational database access via the excellent [jOOQ](http://jooq.org) library.

Key Features
------------
* Linking Dropwizard + jOOQ
* Java 11/17+ compatible, depending on jOOQ version
* Tested, Built, Signed, and Published with GitHub actions to Maven Central

Version Matrix
--------------

jOOQ only supports certain versions of Java with the open source edition. Dropwizard also now has version 3 which
maintains the `javax` namespace, and version 4 which goes ot `jakarta`.

jOOQ 3.16 is the last version which supports Java 11. jOOQ 3.17+ supports Java 17+. Dropwizard 3.0 and 4.0 require
Java 11. This current build is compiled against jOOQ 3.16 and Dropwizard 3.0; making it Java 8+ compatible with
`javax` as the namespace.

The versioning system I am using is a bit odd, but helps give everyone the versions they need. Because this is
middleware between Dropwizard and jOOQ, I need to note which versions that version of the library is compiled against.

The version key is: [this library version] . [Dropwizard] . [jOOQ]. Version `1.0.0` of this library, built with
Dropwizard `3.0.0` and jOOQ `3.16.8` will be `100.300.3168`. If you need Dropwizard 4.0.0 and jOOQ 3.18.2, you would
need `100.400.3182`.

Building
--------

The `build.sh` script in this repo does the building, it reads in `build_versions.txt` then loops through, compiling
the library against different versions of Dropwizard and jOOQ.

Support
-------

Please file bug reports and feature requests in [GitHub issues](https://github.com/daberkow/droptools/issues).


License
-------

Copyright (c) 2014-2020 Benjamin Bader

This library is licensed under the Apache License, Version 2.0.

See http://www.apache.org/licenses/LICENSE-2.0.html or the LICENSE file in this repository for the full license text.
