enable_testing()

find_package(Boost COMPONENTS unit_test_framework REQUIRED)

# make tests run through valgrind
set (CMAKE_MEMORYCHECK_COMMAND         "/usr/bin/valgrind")
set (CMAKE_MEMORYCHECK_COMMAND_OPTIONS "--trace-children=yes --leak-check=full --track-origins=yes --error-exitcode=1 --quiet")
set (VALGRIND_CMD                      "${CMAKE_MEMORYCHECK_COMMAND} ${CMAKE_MEMORYCHECK_COMMAND_OPTIONS}")
separate_arguments(VALGRIND_CMD)

# function which 
# - creates a test executable
# - adds it to ctest
# - automatically runs the tests and creates a test.passed sentinal file when they pass
# - adds the tests to a phony target
function(register_test test target src deps)
 
    # create the test executable, linked against dependencies and boost-test
    add_executable       (${test} ${src})
    target_link_libraries(${test} ${deps} ${Boost_UNIT_TEST_FRAMEWORK_LIBRARY})

	# add the test to ctest
    add_test(
        NAME    ${test}
        COMMAND ${VALGRIND_CMD} $<TARGET_FILE:${test}>
        )  

    # create test.passed target which runs this test through cmake and creates a sentinel file if it passes
    add_custom_command(
        OUTPUT  ${test}.passed
        COMMAND ctest --build-config $<CONFIGURATION> --tests-regex ${test} --output-on-failure 
        COMMAND ${CMAKE_COMMAND} -E touch ${test}.passed
        DEPENDS ${test}
        )

    # create test.run target which depends on test.passed
    add_custom_target(${test}.run
        DEPENDS ${test}.passed
        )

    # add test.run as a dependency of target, so 'make target' will build and run the tests
	add_dependencies(${target}
		${test}.run
		)

endfunction()