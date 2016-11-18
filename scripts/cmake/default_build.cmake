include_guard(__included_default_build)

# allow users to specify build variant several ways:
#
#   all of the following are equivalent:
#
#     cmake -Dbuild=debug ..
#     cmake -DBUILD=debug ..
#     cmake -DVARIANT=debug ..
#     cmake -DCMAKE_BUILD_TYPE=debug ..

if(variant)
    set(CMAKE_BUILD_TYPE ${variant})
endif()

if(build)
    set(CMAKE_BUILD_TYPE ${build})
endif()

if(Variant)
    set(CMAKE_BUILD_TYPE ${Variant})
endif()

if(Build)
    set(CMAKE_BUILD_TYPE ${Build})
endif()

if(VARIANT)
    set(CMAKE_BUILD_TYPE ${VARIANT})
endif()

if(BUILD)
    set(CMAKE_BUILD_TYPE ${BUILD})
endif()

# if no build variant has been specified, default to debug
if (NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Debug")
endif()

# allow debug/release to be specified in any case
string(TOUPPER ${CMAKE_BUILD_TYPE} BUILD_VARIANT)

# set the requested build variant
if (BUILD_VARIANT STREQUAL "DEBUG")
    set(CMAKE_BUILD_TYPE "Debug")
elseif (BUILD_VARIANT STREQUAL "RELEASE")
    set(CMAKE_BUILD_TYPE "Release")
elseif (BUILD_VARIANT STREQUAL "RELWITHDEBINFO")
    set(CMAKE_BUILD_TYPE "Release")
elseif (BUILD_VARIANT STREQUAL "MINSIZEREL")
    set(CMAKE_BUILD_TYPE "Release")
else()
    message(FATAL_ERROR "Unknown build type: ${CMAKE_BUILD_TYPE}")
endif()
