
function(require_boost)

	find_package       (Boost REQUIRED)
    include_directories(${Boost_INCLUDE_DIRS}) 

endfunction()