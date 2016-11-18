include_guard(__included_module)

function(module MODULE)
 
    # create a phony target MODULE if it doesn't already exist
    if (NOT TARGET ${MODULE})
        add_custom_target(${MODULE}
            ALL
            )
    endif()

endfunction()

function(add_to_module PARENT DEPENDENCY)
 
    module(${PARENT})

    # add the dependency to be built when PARENT is built
    add_dependencies(${PARENT}
        ${DEPENDENCY}
        )

endfunction()
