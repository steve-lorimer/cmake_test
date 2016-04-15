function(register_test NAME)
 
    # register the test with ctest
    add_test          (NAME ${NAME} COMMAND $<TARGET_FILE:${NAME}> WORKING_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})  

    # make the test run as part of the build process
	add_custom_command(TARGET ${NAME} POST_BUILD COMMAND ${NAME})

	# add the test to a custom target (make check) and make it depend on the test executable, so the test will be built if it is outdated
 	#add_custom_target (check COMMAND ${CMAKE_CTEST_COMMAND} DEPENDS ${NAME})

endfunction()