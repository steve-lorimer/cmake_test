file(GLOB SOURCES "*.cpp")

set(NAME lib1_test)
set(LIBS liblib1.a)


add_executable(${NAME} ${SOURCES})
target_link_libraries(${NAME} ${LIBS})
