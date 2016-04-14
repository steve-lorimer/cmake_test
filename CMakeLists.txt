cmake_minimum_required (VERSION 3.2.2)
project (cmake_test CXX)

if (NOT CMAKE_BUILD_TYPE)
	set(CMAKE_BUILD_TYPE "Debug")
endif()

add_subdirectory (lib1)
add_subdirectory (lib2)
add_subdirectory (app)
add_subdirectory (gui)

#include_directories ("${PROJECT_SOURCE_DIR}")
include_directories (".")

# 3rd party dependencies
###############################################
# boost
find_package(Boost) 
if (NOT Boost_FOUND)
    message (SEND_ERROR "unable to find boost")
else()
    include_directories (${Boost_INCLUDE_DIRS}) 
endif()	  

# compiler flags
if (CMAKE_COMPILER_IS_GNUCXX)
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++14")
endif()

# debug settings
if ("${CMAKE_BUILD_TYPE}" MATCHES "Debug")

    message (STATUS "building debug")


	set_property (DIRECTORY APPEND PROPERTY COMPILE_DEFINITIONS $<$<CONFIG:Debug>:_DEBUG> )
	
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
set (CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/.build/${CMAKE_BUILD_TYPE}/bin)
set (CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/.build/${CMAKE_BUILD_TYPE}/lib)
set (CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/.build/${CMAKE_BUILD_TYPE}/lib)

# C++11 is mendatory
set (${CXX_STANDARD_REQUIRED} ON)
