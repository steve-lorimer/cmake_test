include(module)

enable_testing()

find_package(Boost COMPONENTS unit_test_framework REQUIRED)

# make tests run through valgrind
set (CMAKE_MEMORYCHECK_COMMAND         "/usr/bin/valgrind")
set (CMAKE_MEMORYCHECK_COMMAND_OPTIONS "--trace-children=yes --leak-check=full --track-origins=yes --error-exitcode=1 --quiet")
set (VALGRIND_CMD                      "${CMAKE_MEMORYCHECK_COMMAND} ${CMAKE_MEMORYCHECK_COMMAND_OPTIONS}")
separate_arguments(VALGRIND_CMD)


function(test)
    # - creates a test executable
    # - adds it to ctest
    # - automatically runs the tests and creates a test.passed sentinal file when they pass
    # - adds the tests to 'module' target
    # arguments:
    # NAME   test_name
    # MODULE module
    # SRCS   sources*
    # DEPS   dependencies*

    # parse arguments
    set(options)
    set(values NAME MODULE)
    set(lists  SRCS DEPS)
    cmake_parse_arguments(TEST "${options}" "${values}" "${lists}" "${ARGN}")
 
    # create the test executable, linked against dependencies and boost-test
    add_executable       (${TEST_NAME} ${TEST_SRCS})
    target_link_libraries(${TEST_NAME} ${TEST_DEPS} ${Boost_UNIT_TEST_FRAMEWORK_LIBRARY})

	# add the test to ctest
    add_test(
        NAME    ${TEST_NAME}
        COMMAND ${VALGRIND_CMD} $<TARGET_FILE:${TEST_NAME}>
        )  

    # create test.passed module which runs this test through cmake and creates a sentinel file if it passes
    add_custom_command(
        OUTPUT  ${TEST_NAME}.passed
        COMMAND ctest --build-config $<CONFIGURATION> --tests-regex ${TEST_NAME} --output-on-failure 
        COMMAND ${CMAKE_COMMAND} -E touch ${TEST_NAME}.passed
        DEPENDS ${TEST_NAME}
        )

    # create test.run module which depends on test.passed
    add_custom_target(${TEST_NAME}.run
        DEPENDS ${TEST_NAME}.passed
        )

    # add test.run as a dependency of module, so 'make module' will build and run the tests
    if (TEST_MODULE)
        add_to_module(${TEST_MODULE} ${TEST_NAME}.run)
    endif()

endfunction()

