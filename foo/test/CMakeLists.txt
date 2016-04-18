file(GLOB src "*.cpp")

#add_boost_test(foo_test foo ${src} _foo)

add_executable       (foo_test ${src})
target_link_libraries(foo_test _foo  ${Boost_UNIT_TEST_FRAMEWORK_LIBRARY})

add_test(
	NAME    foo_test          
	COMMAND $<TARGET_FILE:foo_test> 
	WORKING_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
	)  

add_custom_command(
    OUTPUT  foo_test.passed
    COMMAND foo_test
    COMMAND ${CMAKE_COMMAND} -E touch foo_test.passed
    DEPENDS foo_test
    )

add_custom_target(foo_test.passed.do
	ALL
	DEPENDS foo_test.passed
	)

add_dependencies(foo
	foo_test.passed.do
	)




