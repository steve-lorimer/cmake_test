include_guard(__included_install_makefile)

# copy the makefile into the source tree to mimic in-source builds
function(install_makefile)
    if(NOT DISABLE_IN_SOURCE_BUILD)
        configure_file(${CMAKE_SCRIPTS_DIR}/makefile ${CMAKE_CURRENT_SOURCE_DIR}/makefile COPYONLY)
    endif()
endfunction()
