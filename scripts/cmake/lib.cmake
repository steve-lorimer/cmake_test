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
 
    # link type
    if (LIB_STATIC)
        set(LINK STATIC)
    elseif (LIB_SHARED)
        set(LINK SHARED)
    else()
        message (SEND_ERROR "No linking type specified for ${LIB_NAME} library")
    endif()

    if (LIB_PROTO)
        protobuf_generate_cpp(
            PROTO_SRCS
            PROTO_HDRS
                ${LIB_PROTO}
        )
        # protobuf files are put into the binary output directory
        include_directories(${CMAKE_CURRENT_BINARY_DIR})
    endif()

    add_library          (${LIB_NAME} ${LINK} ${LIB_SRCS} ${PROTO_SRCS})
    target_link_libraries(${LIB_NAME} ${LIB_LIBS})

    # add lib as a dependency of module, so 'make module' will build the lib
    if (LIB_MODULE)
        add_to_module(${LIB_MODULE} ${LIB_NAME})
    endif()

endfunction()

