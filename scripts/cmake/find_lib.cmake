include_guard(__included_find_lib)

function(do_find_lib LIB_NAME SUFFIX OUT)

    set(CMAKE_FIND_LIBRARY_SUFFIXES ${SUFFIX})
    set(FOUND FOUND-NOTFOUND)

    find_library(FOUND ${LIB_NAME})

    if(NOT FOUND)
        message(SEND_ERROR "unable to find library ${LIB_NAME}")
    endif()

    set(${OUT} ${FOUND} PARENT_SCOPE)

endfunction()

#####################################################################################

function(find_static_lib LIB_NAME OUT)

    if (WIN32 OR MSVC)
        set(SUFFIX ".lib")
    elseif (UNIX)
        set(SUFFIX ".a")
    endif()      

    do_find_lib(${LIB_NAME} ${SUFFIX} FOUND)

    set(${OUT} ${FOUND} PARENT_SCOPE)

endfunction()

#####################################################################################

function(find_shared_lib LIB_NAME OUT)

    if (WIN32 OR MSVC)
        set(SUFFIX ".dll")
    elseif (UNIX)
        set(SUFFIX ".so")
    endif()      

    do_find_lib(${LIB_NAME} ${SUFFIX} FOUND)

    set(${OUT} ${FOUND} PARENT_SCOPE)

endfunction()

