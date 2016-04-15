file(GLOB SOURCES "*.cpp")

set(NAME lib2_test)
set(LIBS lib2)

add_executable(${NAME} ${SOURCES})
target_link_libraries(${NAME} ${LIBS})
