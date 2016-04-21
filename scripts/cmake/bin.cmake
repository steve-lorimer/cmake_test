include_guard(__included_bin)

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
    # PROTO   protobuf files*
    # LIBS    libraries*
    # DEPS    dependencies*
    # MODULE  module
    # INSTALL 
    # TAG

    # parse arguments
    set(options INSTALL TAG)
    set(values  NAME MODULE)
    set(lists   SRCS PROTO LIBS DEPS)
    cmake_parse_arguments(BIN "${options}" "${values}" "${lists}" "${ARGN}")
 
    if (DEBUG_CMAKE)
        message(STATUS "BIN: NAME=${BIN_NAME} MODULE=${BIN_MODULE} PROTO=${BIN_PROTO} LIBS=${BIN_LIBS} DEPS=${BIN_DEPS} INSTALL=${BIN_INSTALL} TAG=${BIN_TAG}")
    endif()

    # generate protobuf files if required
    if (BIN_PROTO)
        protobuf_generate_cpp(
            PROTO_SRCS
            PROTO_HDRS
                ${BIN_PROTO}
            )

        # automatically link against the protobuf libraries if proto files have been specified
        set(PROTO_LIBS ${PROTOBUF_LIBRARIES})

        # protobuf files are put into the binary output directory
        include_directories(${CMAKE_CURRENT_BINARY_DIR})
    endif()

    add_executable(${BIN_NAME} ${BIN_SRCS} ${PROTO_SRCS})

    target_link_libraries(${BIN_NAME} 
            ${BIN_LIBS} 
            pthread
            rt
        optimized 
            ${TCMALLOC}
            ${PROTO_LIBS}
            )

    # in case we get linking problems that are too finicky to solve
    # target_link_libraries(${BIN_NAME} 
    #     -Wl,--start-group 
    #             ${BIN_LIBS} 
    #             pthread 
    #         optimized 
    #             tcmalloc_minimal.a 
    #     -Wl,--end-group
    #     )

    if(BIN_DEPS)
        add_dependencies (${BIN_NAME} ${BIN_DEPS})
    endif()

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

