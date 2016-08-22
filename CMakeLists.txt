cmake_minimum_required (VERSION 3.2.2)
project (cmake_test CXX)

list (APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/scripts/cmake")
include(all)

include_directories ("${CMAKE_SOURCE_DIR}")

add_subdirectory (3rd-party)
add_subdirectory (foo)
add_subdirectory (bar)
add_subdirectory (app)
# add_subdirectory (gui)

# copy the makefile into the source tree to mimic in-source builds
configure_file(${CMAKE_SOURCE_DIR}/scripts/cmake/makefile ${CMAKE_CURRENT_SOURCE_DIR}/makefile COPYONLY)
