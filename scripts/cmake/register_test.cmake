function(register_test test tgt)
 
    # register the test with ctest
    add_test          (NAME ${test}          COMMAND                 $<TARGET_FILE:${test}> WORKING_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})  
    # add_test          (NAME ${test}_memcheck COMMAND ${VALGRIND_CMD} $<TARGET_FILE:${test}> WORKING_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})  

    add_custom_command(
        OUTPUT  ${test}.passed
        #COMMAND ctest -C $<CONFIGURATION> --output-on-failure
        COMMAND ${test}
        COMMAND ${CMAKE_COMMAND} -E touch ${test}.passed
        DEPENDS ${test}
        )

    # add_custom_command(
    #     OUTPUT  ${test}_memcheck.passed
    #     #COMMAND ctest -C $<CONFIGURATION> --output-on-failure
    #     COMMAND ${test}_memcheck
    #     COMMAND ${CMAKE_COMMAND} -E touch ${test}_memcheck.passed
    #     DEPENDS ${test}
    #     )

	add_dependencies(${tgt}
		DEPENDS ${test}.passed
		)

endfunction()