include_guard(__included_lib)

function(lib)
    # - creates a library
    # - adds the library to 'module' target
    #
    # arguments:
    # NAME   lib_name
    # MODULE module
    # SRCS   sources*
    # PROTO  protobuf files*
    # LIBS   dependencies*
    # STATIC/SHARED

    # parse arguments
    set(options STATIC SHARED)
    set(values  NAME MODULE)
    set(lists   SRCS PROTO LIBS)
    cmake_parse_arguments(LIB "${options}" "${values}" "${lists}" "${ARGN}")

    if (DEBUG_CMAKE)
        message(STATUS "LIB: NAME=${LIB_NAME} MODULE=${LIB_MODULE} PROTO=${LIB_PROTO} LIBS=${LIB_LIBS} DEPS=${LIB_DEPS} SRCS=${LIB_SRCS}")
    endif()

    # link type
    if (LIB_SHARED)
        set(LINK SHARED)
    else()
        set(LINK STATIC) # default to STATIC if nothing is specified
    endif()

    # generate protobuf files if required
    if (LIB_PROTO)
        protobuf_generate_cpp(
            PROTO_SRCS
            PROTO_HDRS
                ${LIB_PROTO}
            )

        # automatically link against the protobuf libraries if proto files have been specified
        set(PROTO_LIBS ${PROTOBUF_LIBRARIES})

        # protobuf files are put into the binary output directory
        include_directories(${CMAKE_CURRENT_BINARY_DIR})
    endif()

    add_library          (${LIB_NAME} ${LINK} ${LIB_SRCS} ${PROTO_SRCS})
    target_link_libraries(${LIB_NAME} ${LIB_LIBS} ${PROTO_LIBS})

    # add lib as a dependency of module, so 'make module' will build the lib
    if (LIB_MODULE)
        add_to_module(
            ${LIB_MODULE}
            ${LIB_NAME}
            )
    endif()

endfunction()
