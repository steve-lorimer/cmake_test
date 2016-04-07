##cmake

Search for all `.cpp` files in `src` directory, and add to `${SOURCES}`

    file(GLOB SOURCES "src/*.cpp")

Create an executable called `app_name` from `${SOURCES}`

    add_executable(app_name ${SOURCES})

Create a static lib called `lib_name` from `${SOURCES}`

    add_library(lib_name STATIC ${SOURCES})

Link a library

    set(LIBS lib_foo.a)
    link_directories(../lib_foo/build)
    target_link_libraries(app_name ${LIBS})

###Pull in CMakeLists from subdirectories

    add_subdirectory(foo)

###Create a version file

    set (FOO_VERSION_MAJOR 1)
    set (FOO_VERSION_MINOR 0)

    configure_file (
      "${PROJECT_SOURCE_DIR}/version.h.in"
      "${PROJECT_BINARY_DIR}/version.h"
      )

Now create the `version.h.in` file with the following contents:

    #define FOO_VERSION_MAJOR @FOO_VERSION_MAJOR@
    #define FOO_VERSION_MINOR @FOO_VERSION_MINOR@

###Configurable options

    option(USE_FOO "Use feature foo" ON)

    if (USE_FOO)
        add_subdirectory(foo)
        set (EXTRA_LIBS ${EXTRA_LIBS} foo)
    endif()

    target_link_libraries(app_name, ${EXTRA_LIBS})

We can also add `#cmakedefine USE_FOO` to `version.h.in` to have a `#define` added if the option is enabled

###Generated files

Generate `file.h` by running `FooCmd`:

    add_custom_command (
      OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/file.h
      COMMAND FooCmd args
      DEPENDS FooCmd
      )

If `FooCmd` is created by `cmake`, then we can make the `custom_command` `DEPEND` on it

Add generated `file.h` to a library:

    include_directories( ${CMAKE_CURRENT_BINARY_DIR} )
    add_library(FooLib, ${CMAKE_CURRENT_BINARY_DIR}/file.h)

