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

    if (FOUND_${LIB_NAME}${SUFFIX})
        get_filename_component(ABS_FILE ${FOUND_${LIB_NAME}${SUFFIX}} ABSOLUTE)
        message(STATUS "Found library ${ABS_FILE}")
    elseif(NOT ${FIND_OPTIONAL})
        message(SEND_ERROR "Unable to find library ${LIB_NAME}")
    endif()

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

    if(FIND_OPTIONAL)
        set(OPTIONAL "OPTIONAL")
    endif()

    do_find_lib(
        ${LIB_NAME} 
        ${CMAKE_STATIC_LIBRARY_SUFFIX}
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

    if(FIND_OPTIONAL)
        set(OPTIONAL "OPTIONAL")
    endif()

    do_find_lib(
        ${LIB_NAME} 
        ${CMAKE_SHARED_LIBRARY_SUFFIX}
        FOUND 
        PATHS
            ${FIND_PATHS}
        ${OPTIONAL})

    set(${OUT} ${FOUND} PARENT_SCOPE)

endfunction()

#####################################################################################
# Finds a gcc-specific library (e.g. quadmath, asan, lsan etc)
# Location will depend on the compiler version in use
# This allows portability across dev and build machines with different gcc compilers
#####################################################################################
macro(find_gcc_lib LIB_NAME OUT)
    # arguments:
    # LIB_NAME library name within compiler tree
    # OUT      output variable

    if (CMAKE_COMPILER_IS_GNUCC)
        execute_process(COMMAND ${CMAKE_CXX_COMPILER} -print-libgcc-file-name OUTPUT_VARIABLE LIB_GCC_FILE)
        get_filename_component(LIB_GCC_DIR ${LIB_GCC_FILE} DIRECTORY)
        find_static_lib(${LIB_NAME} ${OUT} OPTIONAL PATHS ${LIB_GCC_DIR})
        if (NOT ${OUT})
            find_shared_lib(${LIB_NAME} ${OUT} OPTIONAL PATHS ${LIB_GCC_DIR})
        endif()
     endif()
endmacro()

#####################################################################################
# Alias the library to the in-tree version
# This will allow us to easily switch to out-of-tree versions for faster builds
#####################################################################################
function(use_in_tree_lib LIB_NAME OUT)
    # arguments:
    # LIB_NAME library name within viv source tree
    # OUT      output variable

    set(FULL_LIB_NAME ${LIB_NAME}.lib)
    message(STATUS "Using ${OUT}=${FULL_LIB_NAME}")

    set(${OUT} ${FULL_LIB_NAME} PARENT_SCOPE)

endfunction()

