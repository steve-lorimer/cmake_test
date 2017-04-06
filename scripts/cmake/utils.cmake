include_guard(__included_utils)

function(add_unique ITEM LIST)
    list(FIND ${LIST} ${ITEM} exists)
    if(${exists} EQUAL -1)
        list(APPEND ${LIST} ${ITEM})
    endif()
    set(${LIST} ${${LIST}} PARENT_SCOPE)
endfunction()

#####################################################################################
# Work around CMP0003: Libraries linked via full path no longer produce linker search paths
# Don't link with absolute paths, just link using the library name, and add the path to the library
# search path
# This is only relevant for shared libraries
#####################################################################################
    # arguments:
    # LIBS libraries with absolute paths
    # OUT  output variable - relevant library paths will be split

function(clean_link_libs OUT LIBS)

    foreach(LIB ${LIBS})
        get_filename_component(EXTENSION ${LIB} EXT)
        if ("${EXTENSION}" STREQUAL ${CMAKE_SHARED_LIBRARY_SUFFIX})
            get_filename_component(DIR  ${LIB} DIRECTORY)
            if(DIR)
                # Add path to the linker search path
                add_unique(-L${DIR} OUT)
            endif()

            get_filename_component(FILE ${LIB} NAME)
            add_unique(${FILE} OUT)
        else()
            add_unique(${LIB} OUT)
        endif()
    endforeach()

    set(${OUT} ${${OUT}} PARENT_SCOPE)

endfunction()

