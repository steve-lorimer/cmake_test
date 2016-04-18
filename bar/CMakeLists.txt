file(GLOB SOURCES "*.cpp")

add_library(bar STATIC ${SOURCES})
target_link_libraries(bar foo)

add_subdirectory (test)