include_guard(__included_install_makefile)

# copy the makefile into the source tree to mimic in-source builds
function(install_makefile)
    configure_file(${CMAKE_SOURCE_DIR}/scripts/cmake/makefile ${CMAKE_CURRENT_SOURCE_DIR}/makefile COPYONLY)
endfunction()
