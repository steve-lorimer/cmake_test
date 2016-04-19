cmake_minimum_required (VERSION 3.2.2)
project (cmake_test CXX)

if (NOT CMAKE_BUILD_TYPE)
	set(CMAKE_BUILD_TYPE "Debug")
endif()

# add our custom cmake modules
list (APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/scripts/cmake")
include(ccache)
include(boost)
include(module)
include(bin)
include(qt)
include(qt_bin)
include(lib)
include(test)

include_directories ("${CMAKE_SOURCE_DIR}")

# 3rd party dependencies
require_boost()

# compiler flags
if (CMAKE_COMPILER_IS_GNUCXX)
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++14")
endif()

# debug settings
# if ("${CMAKE_BUILD_TYPE}" MATCHES "Debug")
#     message (STATUS "building debug")
# 	link_directories (${link_directories} ${CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG}) 

# # release settings
# elseif ("${CMAKE_BUILD_TYPE}" MATCHES "Release")
#     message (STATUS "building release")
# 	link_directories (${link_directories} ${CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE}) 

# # unsupported build variant
# else()

#     message (SEND_ERROR "unsupported build variant")

# endif()

add_subdirectory (foo)
add_subdirectory (bar)
add_subdirectory (app)
add_subdirectory (gui)



