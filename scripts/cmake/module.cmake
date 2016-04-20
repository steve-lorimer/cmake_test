if(__included_module)
    return()
endif()
set(__included_module YES)

function(add_to_module MODULE DEPENDENCY)
 
	# create a phony target MODULE if it doesn't already exist
    if (NOT TARGET ${MODULE})
        add_custom_TARGET(${MODULE}
            ALL
            )
    endif()

    # add the dependency to be built when MODULE is built
    add_dependencies(${MODULE}
        ${DEPENDENCY}
        )

endfunction()