include_guard(__included_find_lib)

function(find_static_library LIB_NAME OUT)

    if (WIN32 OR MSVC)
        set(CMAKE_FIND_LIBRARY_SUFFIXES ".lib")
    elseif (UNIX)
        set(CMAKE_FIND_LIBRARY_SUFFIXES ".a")
    endif()      

    find_library(
        FOUND
        ${LIB_NAME}
    )

    if(NOT FOUND)
        message(SEND_ERROR "unable to find static library ${LIB_NAME}")
    endif()

    set(${OUT} ${FOUND} PARENT_SCOPE)

endfunction()
