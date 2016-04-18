include(register_test)

function(add_boost_test test tgt src deps)
 
 	# create the test executable, linked against dependencies and boost-test
    add_executable       (${test} ${src})
    target_link_libraries(${test} ${deps} ${Boost_UNIT_TEST_FRAMEWORK_LIBRARY})

    # register the test using our macro
    register_test        (${test} ${tgt})

endfunction()