include_guard(__included_test)
include(module)

enable_testing()

function(test)
    # - creates a test executable
    # - adds it to ctest
    # - automatically runs the tests and creates a test.passed sentinal file when they pass
    # - optionally adds the tests to 'module' target
    #
    # arguments:
    # NAME   test_name
    # SRCS   sources*
    # LIBS   dependencies*
    # MODULE module

    # parse arguments
    set(options NO_VALGRIND)
    set(values NAME MODULE SUPPRESSIONS)
    set(lists  SRCS LIBS)
    cmake_parse_arguments(TEST "${options}" "${values}" "${lists}" "${ARGN}")

    # create the test executable, linked against dependencies and boost-test
    add_executable       (${TEST_NAME} ${TEST_SRCS})
    target_link_libraries(${TEST_NAME}
            ${TEST_LIBS}
        optimized
            ${Boost_UNIT_TEST_FRAMEWORK_LIBRARY}
            pthread
            rt
            ${PROTOBUF}
        )


    # make tests run through valgrind
    set(VALGRIND_BIN  "valgrind")
    set(VALGRIND_OPTS "--leak-check=full --track-origins=yes --error-exitcode=1 --quiet")

    if (TEST_SUPPRESSIONS)
        set(VALGRIND_OPTS "${VALGRIND_OPTS} --suppressions=${CMAKE_CURRENT_SOURCE_DIR}/${TEST_SUPPRESSIONS}")
    endif()

    if (NOT TEST_NO_VALGRIND)
        set(VALGRIND_CMD "${VALGRIND_BIN} ${VALGRIND_OPTS}")
        separate_arguments(VALGRIND_CMD)
    endif()

    # create test.passed module which runs this test through cmake and creates a sentinel file if it passes
    add_custom_command(
        OUTPUT  ${TEST_NAME}.passed
        COMMAND ${VALGRIND_CMD} $<TARGET_FILE:${TEST_NAME}> &> ${TEST_NAME}.output || cat ${TEST_NAME}.output
        COMMAND ${CMAKE_COMMAND} -E touch ${TEST_NAME}.passed
        DEPENDS ${TEST_NAME}
        )

    # create test.run module which depends on test.passed
    add_custom_target(${TEST_NAME}.run
        ALL
        DEPENDS ${TEST_NAME}.passed
        )

    # add test.run as a dependency of module, so 'make module' will build and run the tests
    if(TEST_MODULE)
        add_to_module(
            ${TEST_MODULE}
            ${TEST_NAME}.run
            )
    endif()

endfunction()
