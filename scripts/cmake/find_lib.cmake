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
    set(options OPTIONAL)
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

    if(NOT FOUND_${LIB_NAME}${SUFFIX} AND NOT ${FIND_OPTIONAL})
        message(SEND_ERROR "unable to find library ${LIB_NAME}")
    endif()

    get_filename_component(ABS_FILE ${FOUND_${LIB_NAME}${SUFFIX}} ABSOLUTE)

    set(${OUT} ${ABS_FILE} PARENT_SCOPE)

endfunction()

#####################################################################################

function(find_static_lib LIB_NAME OUT)
    # arguments:
    # LIB_NAME lib_name
    # OUT      output variable
    # PATHS    search paths*

    # parse arguments
    set(options OPTIONAL)
    set(values)
    set(lists   PATHS)
    cmake_parse_arguments(FIND "${options}" "${values}" "${lists}" "${ARGN}")

    if (WIN32 OR MSVC)
        set(SUFFIX ".lib")
    elseif (UNIX)
        set(SUFFIX ".a")
    endif()      

    if(FIND_OPTIONAL)
        set(OPTIONAL "OPTIONAL")
    endif()

    do_find_lib(
        ${LIB_NAME} 
        ${SUFFIX} 
        FOUND 
        PATHS
            ${FIND_PATHS}
        ${OPTIONAL})

    set(${OUT} ${FOUND} PARENT_SCOPE)

endfunction()

#####################################################################################

function(find_shared_lib LIB_NAME OUT)
    # arguments:
    # LIB_NAME lib_name
    # OUT      output variable
    # PATHS    search paths*

    # parse arguments
    set(options OPTIONAL)
    set(values)
    set(lists   PATHS)
    cmake_parse_arguments(FIND "${options}" "${values}" "${lists}" "${ARGN}")

    if (WIN32 OR MSVC)
        set(SUFFIX ".dll")
    elseif (UNIX)
        set(SUFFIX ".so")
    endif()      

    if(FIND_OPTIONAL)
        set(OPTIONAL "OPTIONAL")
    endif()

    do_find_lib(
        ${LIB_NAME} 
        ${SUFFIX} 
        FOUND 
        PATHS
            ${FIND_PATHS}
        ${OPTIONAL})

    set(${OUT} ${FOUND} PARENT_SCOPE)

endfunction()

