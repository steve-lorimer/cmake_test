cmake_minimum_required (VERSION 3.2.2)
project (cmake_test CXX)

get_filename_component(CMAKE_SCRIPTS_DIR "${CMAKE_SOURCE_DIR}/scripts/cmake" ABSOLUTE)

list (APPEND CMAKE_MODULE_PATH ${CMAKE_SCRIPTS_DIR})
include(all)

include_directories(${CMAKE_SOURCE_DIR})

install_makefile()

add_subdirectory (3rd-party)
add_subdirectory (foo)
add_subdirectory (bar)
add_subdirectory (app)
# add_subdirectory (gui)

