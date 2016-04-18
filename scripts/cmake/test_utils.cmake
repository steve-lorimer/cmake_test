# we have tests!
enable_testing()

include(register_test)

find_package(Boost COMPONENTS unit_test_framework REQUIRED)
include(boost_test)

# make tests run through valgrind
set (CMAKE_MEMORYCHECK_COMMAND, "usr/bin/valgrind")
set (CMAKE_MEMORYCHECK_COMMAND_OPTIONS, "--trace-children=yes --leak-check=full --track-origins=yes --error-exitcode=1 --quiet")

set (VALGRIND_CMD "${CMAKE_MEMORYCHECK_COMMAND} ${CMAKE_MEMORYCHECK_COMMAND_OPTIONS}")
separate_arguments(VALGRIND_CMD)
