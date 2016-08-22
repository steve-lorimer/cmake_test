include_guard(__included_find_lib)

function(do_find_lib LIB_NAME SUFFIX OUT)
    # - searches for a library with a given suffix, optionally in paths
    #
    # arguments:
    # LIB_NAME lib_name
    # SUFFIX   suffix
    # OUT      output variable
    # PATHS    search paths*

    # parse arguments
    set(options)
    set(values)
    set(lists   PATHS)
    cmake_parse_arguments(FIND "${options}" "${values}" "${lists}" "${ARGN}")

    set(CMAKE_FIND_LIBRARY_SUFFIXES ${SUFFIX})

    find_library(
        FOUND_${LIB_NAME}${SUFFIX} 
        ${LIB_NAME}
        PATHS
            ${FIND_PATHS}
        )

    if(NOT FOUND_${LIB_NAME}${SUFFIX})
        message(SEND_ERROR "unable to find library ${LIB_NAME}")
    endif()

    set(${OUT} ${FOUND_${LIB_NAME}${SUFFIX}} PARENT_SCOPE)

endfunction()

#####################################################################################

function(find_static_lib LIB_NAME OUT)
    # arguments:
    # LIB_NAME lib_name
    # OUT      output variable
    # PATHS    search paths*

    # parse arguments
    set(options)
    set(values)
    set(lists   PATHS)
    cmake_parse_arguments(FIND "${options}" "${values}" "${lists}" "${ARGN}")

    if (WIN32 OR MSVC)
        set(SUFFIX ".lib")
    elseif (UNIX)
        set(SUFFIX ".a")
    endif()      

    do_find_lib(
        ${LIB_NAME} 
        ${SUFFIX} 
        FOUND 
        PATHS
            ${FIND_PATHS})

    set(${OUT} ${FOUND} PARENT_SCOPE)

endfunction()

#####################################################################################

function(find_shared_lib LIB_NAME OUT)
    # arguments:
    # LIB_NAME lib_name
    # OUT      output variable
    # PATHS    search paths*

    # parse arguments
    set(options)
    set(values)
    set(lists   PATHS)
    cmake_parse_arguments(FIND "${options}" "${values}" "${lists}" "${ARGN}")

    if (WIN32 OR MSVC)
        set(SUFFIX ".dll")
    elseif (UNIX)
        set(SUFFIX ".so")
    endif()      

    do_find_lib(
        ${LIB_NAME} 
        ${SUFFIX} 
        FOUND 
        PATHS
            ${FIND_PATHS})

    set(${OUT} ${FOUND} PARENT_SCOPE)

endfunction()

