file(GLOB SOURCES "*.cpp")

add_library(lib2 STATIC ${SOURCES})
target_link_libraries(lib2 lib1)

add_subdirectory (test)