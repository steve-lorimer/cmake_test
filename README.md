# Cmake Project

This is a small project I used to learn cmake while migrating an existing build system to [cmake](https://cmake.org/)

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

## Features

### version information

Version information is generated and a version.cc file generated.

The output of printing this information is similar to this:

    build variant : release
    build date    : Feb 27 2018 10:56:11
    version       : 083b581
    num_commits   : 78
    branch        : master
    ahead_by      : 0
    num_untracked : 0
    user          : steve
    hostname      : ky-steve

### Tests

Tests are run as part of the build process

A failing test breaks the build

All tests are run through valgrind

A memory leak breaks the build

**Files:**

- `scripts/cmake/test.cmake`: cmake function which adds the test and configures it to run as part of the build

### Tagged binaries:

Binaries can be installed to a specified destination as part of the build, and optionally have version information 
included in the filename

Version information tagged onto a binary:

- `branch`  : branch name binary is built from
- `commits` : number of commits in this branch
- `dirty`   : whether the branch is clean, or has uncommitted changes, untracked files etc

**Files:**

- `scripts/cmake/install.cmake`: cmake function which installs the binary, and tags it with version information (wip)

### Modules

Related targets can be added to a "module", such that building the module builds all related targets

eg: `foo` module contains `libfoo` static library and `foo_test`, tests which verify `libfoo`

`foo` exists as a target in the makefiles. `make foo` builds all related targets.

## Build settings

Top level `CMakeLists.txt` includes `all.cmake`, which pulls in all the custom cmake scripts.

Additionally, `all.cmake` pulls in several scripts which configure the build

- `scripts/cmake/ccache.cmake`: builds through `ccache` if it is found
- `scripts/cmake/default_build.cmake`: sets the default build to `Debug` if it hasn't been specified
- `scripts/cmake/compile_flags.cmake`: compiler flags set for the build
- `scripts/cmake/dependencies.cmake`: pulls in 3rd party dependencies

## Quickstart

There is a script `bootstrap` in the root directory which will set up the cmake files automatically.

The bootstrap script will install 2 sets of makefiles, for debug and release builds.

These are installed to `cmake_test/.build/debug` and `cmake_test/.build/release` respectively.

The bootstrap script will also install makefiles into the source tree, allowing you to build from within the source tree. These makefiles delegate the build to the appropriate out-of-source makefiles.

These in-source makefiles allow you to build either debug or release (debug is default), and to optionally list a target to build (default is all targets at-or-below the current location in the source tree)

Examples

    $ make              # builds all targets at-or-below the current location in the source tree in debug mode
    $ make release      # builds all targets at-or-below the current location in the source tree in release mode
    $ make foo          # builds the foo target in debug mode
    $ make foo release  # builds the foo target in release mode
    
    