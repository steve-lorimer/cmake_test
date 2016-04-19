# creates a top level phony target to which dependencies may be added
function(add_to_module TARGET DEPENDENCY)
 
    if (NOT TARGET ${TARGET})
        add_custom_TARGET(${TARGET}
            ALL
            )
    endif()

	add_dependencies(${TARGET}
		${DEPENDENCY}
		)

endfunction()