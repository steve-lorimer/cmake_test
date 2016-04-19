# function which 
# - creates a top level phony target 'module'
# - adds 'dep' as a dependency of 'module'
function(add_to_module target dep)
 
    if (NOT TARGET ${target})
        add_custom_target(${target}
            ALL
            )
    endif()

	add_dependencies(${target}
		${dep}
		)

endfunction()