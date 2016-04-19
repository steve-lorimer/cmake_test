include(module)
include(install)

function(bin)
    # - creates a binary 
    # - adds the binary to 'module' target
    # arguments:
    # NAME    bin_name
    # MODULE  module
    # SRCS    sources*
    # DEPS    dependencies*
    # INSTALL 
    # TAG

    # parse arguments
    set(options INSTALL TAG)
    set(values  NAME MODULE)
    set(lists   SRCS DEPS)
    cmake_parse_arguments(BIN "${options}" "${values}" "${lists}" "${ARGN}")
 
    add_executable       (${BIN_NAME} ${BIN_SRCS})
    target_link_libraries(${BIN_NAME} ${BIN_DEPS})

    if (BIN_TAG)
        set(TAG "TAG")
    endif()

    if (BIN_INSTALL)
        install(
            FILE   ${BIN_NAME}
            MODULE ${BIN_MODULE}
            DEST   ${CMAKE_CURRENT_SOURCE_DIR}/${BIN_NAME}
            ${TAG}
            )
    endif()

    # add binary as a dependency of module, so 'make module' will build the binary
    if (BIN_MODULE)
        add_to_module(
            ${BIN_MODULE} 
            ${BIN_NAME}
            )
    endif()

endfunction()

