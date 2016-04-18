file(GLOB src "*.cpp")

#add_boost_test(lib1_test lib1 ${src} _lib1)

add_executable       (lib1_test ${src})
target_link_libraries(lib1_test _lib1  ${Boost_UNIT_TEST_FRAMEWORK_LIBRARY})

add_test(
	NAME    lib1_test          
	COMMAND $<TARGET_FILE:lib1_test> 
	WORKING_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
	)  

add_custom_command(
    OUTPUT  lib1_test.passed
    COMMAND lib1_test
    COMMAND ${CMAKE_COMMAND} -E touch lib1_test.passed
    DEPENDS lib1_test
    )

add_custom_target(lib1_test.passed.do
	ALL
	DEPENDS lib1_test.passed
	)

add_dependencies(lib1
	lib1_test.passed.do
	)




