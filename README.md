# Cmake Project

This is a small project I used to learn cmake while migrating an existing build system
from [boost build](http://www.boost.org/build/) to [cmake](https://cmake.org/)

## Structure

    root
    |
    +---- foo                      # static library 
    |     |
    |     +---- test               # test for foo
    |
    +---- bar                      # static library, uses foo 
    |     |
    |     +---- test               # test for bar
    |
    +---- app                      # command line app, uses foo and bar
    |
    +---- gui                      # qt5 app, uses foo and bar

## Build

- [cmake](https://cmake.org/)

    `mkdir build && cd build && cmake .. && make`

- [boost build](http://www.boost.org/build/)

    `b2`

## Features

### version information

Version information is generated and injected into the build

**Files:**

- `scripts/version.sh`: script which generates the version information
- `scripts/cmake/version.cmake`: cmake function which calls the script
- `Jamroot`: the version script is called directly from the Jamroot when building with boost-build

The output of printing this information is similar to this:

    source version: bd0c2d4
    num commits:    27
    branch:         master
    build variant:  debug
    build date:     Apr 19 2016 16:49:57
    ahead by:       1
    user:           steve
    hostname:       ky-steve

### Tests

Tests are run as part of the build process

A failing test breaks the build

All tests are run through valgrind

A memory leak breaks the build

**Files:**

- `scripts/cmake/test.cmake`: cmake function which adds the test and configures it to run as part of the build
- `foo/test/Jamfile`: boost-build provides this functionality built-in via the `run` rule and `<testing-launcher>`

### Tagged binaries:

Binaries can be installed to a specified destination as part of the build, and optionally have version information 
included in the filename

Version information tagged onto a binary:

- `branch`  : branch name binary is built from
- `commits` : number of commits in this branch
- `dirty`   : whether the branch is clean, or has uncommitted changes, untracked files etc

**Files:**

- `scripts/tag.sh`: script with generates the version information
- `scripts/cmake/install.cmake`: cmake function which installs the binary, and tags it with version information (wip)

### Modules

Related targets can be added to a "module", such that building the module builds all related targets

eg: `foo` module contains `libfoo` static library and `foo_test`, tests which verify `libfoo`

`foo` exists as a target in the makefiles. `make foo` builds all related targets.

**Files:**

- `scripts/module.sh`: script with creates the module target and adds a related target as a dependency

## Build settings

Top level `CMakeLists.txt` includes `all.cmake`, which pulls in all the custom cmake scripts.

Additionally, `all.cmake` pulls in several scripts which configure the build

- `scripts/cmake/ccache.cmake`: builds through `ccache` if it is found
- `scripts/cmake/default_build.cmake`: sets the default build to `Debug` if it hasn't been specified
- `scripts/cmake/compile_flags.cmake`: compiler flags set for the build
- `scripts/cmake/dependencies.cmake`: pulls in 3rd part dependencies
