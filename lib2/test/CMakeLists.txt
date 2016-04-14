file(GLOB SOURCES "*.cpp")

set(NAME lib2_test)
set(LIBS liblib2.a)

add_executable(${NAME} ${SOURCES})
target_link_libraries(${NAME} ${LIBS})
