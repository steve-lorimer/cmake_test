include(message)

# build variant
string(TOLOWER "${CMAKE_BUILD_TYPE}" BUILD_VARIANT)

# compiler and version
if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")

    set(COMPILER "clang")
    execute_process(
        OUTPUT_VARIABLE COMPILER_VERSION
        COMMAND         clang -dumpversion
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )

elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")

    set(COMPILER "gcc")
    execute_process(
        OUTPUT_VARIABLE COMPILER_VERSION
        COMMAND         gcc -dumpversion
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )

endif()

message(STATUS "build=${BUILD_VARIANT} compiler=${COMPILER}-${COMPILER_VERSION}")
