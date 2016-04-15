file(GLOB SOURCES "*.cpp")

add_library(lib1 STATIC ${SOURCES})

add_subdirectory (test)