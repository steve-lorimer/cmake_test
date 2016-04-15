file(GLOB SOURCES "*.cpp")

set(NAME app)
set(LIBS lib2)

add_executable(app ${SOURCES})
target_link_libraries(app ${LIBS})
