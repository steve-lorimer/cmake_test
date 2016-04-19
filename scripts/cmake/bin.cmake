include(module)
include(install)

function(bin)
    # - creates a binary 
    # - optionally adds the binary to 'module' target
    # - optionally installs the binary
    # - optionally installs a tagged binary
    #
    # arguments:
    # NAME    bin_name
    # SRCS    sources*
    # DEPS    dependencies*
    # MODULE  module
    # INSTALL 
    # TAG

    # parse arguments
    set(options INSTALL TAG)
    set(values  NAME MODULE)
    set(lists   SRCS DEPS)
    cmake_parse_arguments(BIN "${options}" "${values}" "${lists}" "${ARGN}")
 
    add_executable       (${BIN_NAME} ${BIN_SRCS})
    target_link_libraries(${BIN_NAME} ${BIN_DEPS})

    # install the binary, and optionally a tagged binary, if requested
    if(BIN_INSTALL)
        if(BIN_TAG)
            set(TAG "TAG")
        endif()

        install(
            FILE   ${BIN_NAME}
            MODULE ${BIN_MODULE}
            DEST   ${CMAKE_CURRENT_SOURCE_DIR}/${BIN_NAME}
            ${TAG}
            )
    endif()

    # add binary as a dependency of module, so 'make module' will build the binary
    if(BIN_MODULE)
        add_to_module(
            ${BIN_MODULE} 
            ${BIN_NAME}
            )
    endif()

endfunction()

