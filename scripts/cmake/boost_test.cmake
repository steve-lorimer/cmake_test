include(register_test)

function(add_boost_test NAME SOURCES DEPENDENCIES)
 
 	# create the test executable, linked against dependencies and boost-test
    add_executable       (${NAME} ${SOURCES})
    target_link_libraries(${NAME} ${DEPENDENCIES} ${Boost_UNIT_TEST_FRAMEWORK_LIBRARY})

    # register the test using our macro
    register_test        (${NAME})

endfunction()