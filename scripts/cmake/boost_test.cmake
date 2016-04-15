function(add_boost_test NAME SOURCES DEPENDENCIES)
 
    add_executable       (${NAME} ${SOURCES})
    target_link_libraries(${NAME} ${DEPENDENCIES} ${Boost_UNIT_TEST_FRAMEWORK_LIBRARY})
    add_test             (${NAME} ${NAME})  
 
endfunction()