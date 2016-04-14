file(GLOB SOURCES "*.cpp")

add_library(lib2 STATIC ${SOURCES})
add_subdirectory (test)