cmake_minimum_required (VERSION 3.2.2)
project (cmake_test CXX)

list (APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/scripts/cmake")
include(all)

include_directories ("${CMAKE_SOURCE_DIR}")

add_subdirectory (3rd-party)
add_subdirectory (foo)
add_subdirectory (bar)
add_subdirectory (app)
add_subdirectory (gui)



