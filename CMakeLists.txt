cmake_minimum_required (VERSION 3.2.2)
project (cmake_test CXX)

if (NOT CMAKE_BUILD_TYPE)
	set(CMAKE_BUILD_TYPE "Debug")
endif()

# add our custom cmake modules
list (APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/scripts/cmake")
include(ccache)
include(test_utils)

# CMAKE_SOURCE_DIR   refers to the folder where the top-level CMakeLists.txt is defined
# PROJECT_SOURCE_DIR refers to the folder of the CMakeLists.txt containing the most recent project() command
include_directories ("${CMAKE_SOURCE_DIR}")


# 3rd party dependencies
include(require_boost)

# compiler flags
if (CMAKE_COMPILER_IS_GNUCXX)
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++14")
endif()

# debug settings
if ("${CMAKE_BUILD_TYPE}" MATCHES "Debug")
    message (STATUS "building debug")
	link_directories (${link_directories} ${CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG}) 

# release settings
elseif ("${CMAKE_BUILD_TYPE}" MATCHES "Release")
    message (STATUS "building release")
	link_directories (${link_directories} ${CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE}) 

# unsupported build variant
else()

    message (SEND_ERROR "unsupported build variant")

endif()

# specify where compiled files must go
# set (CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${CMAKE_BUILD_TYPE}/bin)
# set (CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${CMAKE_BUILD_TYPE}/lib)
# set (CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${CMAKE_BUILD_TYPE}/lib)

# C++11 is mendatory
set (${CXX_STANDARD_REQUIRED} ON)

add_subdirectory (lib1)
#add_subdirectory (lib2)
#add_subdirectory (app)
#add_subdirectory (gui)



