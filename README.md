## Requirements

- boost-build : for building the project with bjam
- boost-test  : for unit tests
- valgrind    : for unit tests
- qt5         : for gui
- tcmalloc    : only for `prod` build variant

## Existing build system - [boost build](http://www.boost.org/build/)

### Features

#### Verstion information:

Build process calls a script which generates version information and prints details to stdout upon update

From `Jamroot`:

    Echo [ SHELL "$(TOP)/app/version.sh $(TOP)" ] ;

Result of running `version.sh` is `app/version_details.h`

#### Tagged binaries:

Build process calls a script which tags binaries with version information

Version information tagged onto a binary:

- branch  : branch name binary is built from
- commits : number of commits in this branch
- dirty   : whether the branch is clean, or has uncommitted changes, untracked files etc

From `Jamroot`:

    # creates a variable called $(TAG) which contains current build version information
    local tag = [ SHELL "$(TOP)/scripts/tag.sh" ] ;
    constant TAG : $(tag) ;

From `app/Jamfile`:

    # use $(TAG) defiend in Jamroot to tag the binary, eg: app.<branch>.<num_commits>.dirty
    cp $(>) $(>).$(TAG) 

#### Automated tests:

Tests are part of the build process - a failing test results in a failed build

#### Custom test launchers:

Tests can be run through custom launchers, for example, `valgrind`, so we can verify there are no memory leaks

From 'lib1/test/Jamfile':

    <testing.launcher>"valgrind --leak-check=full --track-origins=yes --error-exitcode=1 --quiet"

If `valgrind` exits with an error (`--error-exitcode=1`), the build fails