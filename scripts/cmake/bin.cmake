include_guard(__included_bin)
include(module)
include(install)
include(install_makefile)

function(bin)
    # - creates a binary
    # - optionally adds the binary to 'module' target
    # - optionally installs the binary to <src_location>/<build_variant>/<install_name>
    # - optionally installs a tagged binary to <src_location>/<build_variant>/<install_name>.tag
    #
    # arguments:
    # NAME    bin_name
    # INSTALL install_name
    # MODULE  module
    # SRCS    sources*
    # PROTO   protobuf files*
    # LIBS    libraries*
    # DEPS    dependencies*
    # TAG

    # parse arguments
    set(options TAG)
    set(values  NAME MODULE INSTALL)
    set(lists   SRCS PROTO LIBS DEPS)
    cmake_parse_arguments(BIN "${options}" "${values}" "${lists}" "${ARGN}")

    if (DEBUG_CMAKE)
        message(STATUS "BIN: NAME=${BIN_NAME} MODULE=${BIN_MODULE} PROTO=${BIN_PROTO} LIBS=${BIN_LIBS} DEPS=${BIN_DEPS} INSTALL=${BIN_INSTALL} TAG=${BIN_TAG} SRCS=${BIN_SRCS}")
    endif()

    # include_directories(${CMAKE_CURRENT_BINARY_DIR})

    # generate protobuf files if required
    if (BIN_PROTO)
        protoc(
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
        optimized
            pthread
            rt
            ${TCMALLOC}
            ${PROTOBUF}
        )

    if(BIN_DEPS)
        add_dependencies (${BIN_NAME} ${BIN_DEPS})
    endif()

    message(STATUS "----- install -----")

    # install the binary, and optionally a tagged binary, if requested
    if(BIN_INSTALL)

      message(STATUS "install")

        if(BIN_TAG)
            set(TAG "TAG")
        endif()

        install(
            FILE   ${CMAKE_CURRENT_BINARY_DIR}/${BIN_NAME}
            MODULE ${BIN_MODULE}
            DEST   ${CMAKE_CURRENT_SOURCE_DIR}/${BIN_INSTALL}
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

    install_makefile()

endfunction()
