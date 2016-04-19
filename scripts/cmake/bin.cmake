function(bin)
    # - creates a binary 
    # - adds the binary to 'module' target
    # arguments:
    # NAME   bin_name
    # MODULE module
    # SRCS   sources*
    # DEPS   dependencies*

    # parse arguments
    set(options)
    set(values  NAME MODULE)
    set(lists   SRCS DEPS)
    cmake_parse_arguments(BIN "${options}" "${values}" "${lists}" "${ARGN}")
 
    add_executable       (${BIN_NAME} ${BIN_LINK} ${BIN_SRCS})
    target_link_libraries(${BIN_NAME} ${BIN_DEPS})

    # add binary as a dependency of module, so 'make module' will build the lib
    if (BIN_MODULE)
        add_to_module(${BIN_MODULE} ${BIN_NAME})
    endif()

endfunction()

