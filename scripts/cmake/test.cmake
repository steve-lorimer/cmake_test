include_guard(__included_test)
include(module)
include(bin)

enable_testing()

function(test)
    # - creates a test executable
    # - adds it to ctest
    # - automatically runs the tests and creates a test.passed sentinal file when they pass
    # - optionally adds the tests to 'module' target
    #
    # arguments:
    # NAME         [test_name]
    # ARGS         [test args*]
    # SRCS         [sources*]
    # PROTO        [protobuf files*]
    # LIBS         [dependencies*]
    # MODULE       [module]
    # SUPPRESSIONS [filename] filename in current directory for suppressions
    # NO_VALGRIND  don't run the test through valgrind

    # parse arguments
    set(options NO_VALGRIND SUPPRESS_NO_VALGRIND_WARNING)
    set(values NAME MODULE SUPPRESSIONS RPATH)
    set(lists  ARGS SRCS PROTO PROTO_INCLUDES LIBS)
    cmake_parse_arguments(ARG "${options}" "${values}" "${lists}" "${ARGN}")

    # all tests have a .test suffix added, their name becomes a module to which they are added
    set(TEST_NAME ${ARG_NAME}.test)

    # since boost 1.60 a unit test executable requires a "--" between the boost
    # framework args and the args passed to the unit test
    # boost1.57 doesn't work if that separator is used
    if(Boost_MINOR_VERSION LESS 60)
        set(ARGS_SEP)
    else()
        set(ARGS_SEP --)
    endif()

    # create the test executable, linked against dependencies and boost-test
    bin(
        # pass ARG_NAME to bin, but specify SUFFIX=test, so the binary target matches TEST_NAME
        NAME
            ${ARG_NAME}
        SUFFIX
            test

        MODULE
            ${ARG_MODULE}

        SRCS
            ${ARG_SRCS}

        PROTO
            ${ARG_PROTO}

        PROTO_INCLUDES
            ${ARG_PROTO_INCLUDES}

        LIBS 
            ${ARG_LIBS}
            ${Boost_UNIT_TEST_FRAMEWORK_LIBRARY}

        RPATH
            ${ARG_RPATH}
        )

    # make tests run through valgrind by default
    if (NOT ARG_NO_VALGRIND)
        set(VALGRIND_BIN  "valgrind")
        set(VALGRIND_OPTS "--leak-check=full --track-origins=yes --error-exitcode=1 --quiet")

        if (ARG_SUPPRESSIONS)
            set(VALGRIND_OPTS "${VALGRIND_OPTS} --suppressions=${CMAKE_CURRENT_SOURCE_DIR}/${ARG_SUPPRESSIONS}")
        endif()

        set(VALGRIND_CMD "${VALGRIND_BIN} ${VALGRIND_OPTS}")
        separate_arguments(VALGRIND_CMD)
    elseif(NOT ARG_SUPPRESS_NO_VALGRIND_WARNING)
        message(REVIEW "${TEST_NAME} will not run through valgrind")
    endif()

    # add the test to ctest
    add_test(
        NAME
            ${TEST_NAME}

        COMMAND
            ${VALGRIND_CMD} $<TARGET_FILE:${TEST_NAME}> ${ARG_ARGS}

        WORKING_DIRECTORY
            ${CMAKE_CURRENT_SOURCE_DIR}
        )

    set(OUTPUT_FILE ${CMAKE_CURRENT_BINARY_DIR}/${ARG_NAME}.output)
    set(PASSED_FILE ${CMAKE_CURRENT_BINARY_DIR}/${ARG_NAME}.passed)

    # create test.passed command which runs this test and creates a sentinel file if it passes
    add_custom_command(
        OUTPUT
            ${PASSED_FILE}

        WORKING_DIRECTORY
            ${CMAKE_CURRENT_SOURCE_DIR}

        COMMAND
            echo "\"${VALGRIND_BIN} ${VALGRIND_OPTS} $<TARGET_FILE:${TEST_NAME}> --report_level=detailed ${ARGS_SEP} ${ARG_ARGS}\"" > ${OUTPUT_FILE}

        COMMAND
            echo "-----------------------------" >> ${OUTPUT_FILE}

        COMMAND
            # the FastClock init often fails under valgrind so disable the exception
            export "SUPPRESS_VIV_FASTCLOCK_INIT_FAILURE=1" && ${VALGRIND_CMD} $<TARGET_FILE:${TEST_NAME}> --report_level=detailed ${ARGS_SEP} ${ARG_ARGS} >> ${OUTPUT_FILE} 2>&1 || (cat ${OUTPUT_FILE} && false)

        COMMAND
            ${CMAKE_COMMAND} -E touch ${PASSED_FILE}

        COMMENT
            "Running ${ARG_NAME} tests"

        DEPENDS
            ${TEST_NAME}

        USES_TERMINAL
        )

    # create test.run target which depends on test.passed
    add_custom_target(${ARG_NAME}.run
        ALL
        DEPENDS ${PASSED_FILE}
        )

    # add the test.run command as a dependency of module, so 'make module' will build and run the test
    add_to_module(
        ${ARG_NAME}
        ${ARG_NAME}.run
        )

endfunction()
