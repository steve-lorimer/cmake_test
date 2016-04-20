if(__included_lib)
    return()
endif()
set(__included_lib YES)

function(lib)
    # - creates a library 
    # - adds the library to 'module' target
    # arguments:
    # NAME   lib_name
    # MODULE module
    # SRCS   sources*
    # LIBS   dependencies*
    # STATIC/SHARED

    # parse arguments
    set(options STATIC SHARED)
    set(values  NAME MODULE)
    set(lists   SRCS LIBS)
    cmake_parse_arguments(LIB "${options}" "${values}" "${lists}" "${ARGN}")
 
    # link type
    if (LIB_STATIC)
        set(LINK STATIC)
    elseif (LIB_SHARED)
        set(LINK SHARED)
    else()
        message (SEND_ERROR "No linking type specified for ${LIB_NAME} library")
    endif()

    add_library          (${LIB_NAME} ${LIB_LINK} ${LIB_SRCS})
    target_link_libraries(${LIB_NAME} ${LIB_LIBS})

    # add lib as a dependency of module, so 'make module' will build the lib
    if (LIB_MODULE)
        add_to_module(${LIB_MODULE} ${LIB_NAME})
    endif()

endfunction()

