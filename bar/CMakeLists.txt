file(GLOB src "*.cpp")

# create a dummy top-level  target which all 'bar' related items will be added to
add_custom_target(bar
	ALL
	)

# add libbar, and make it a dependency of dummy top-level target bar
add_library(libbar STATIC ${src})
target_link_libraries(libbar libfoo)

add_dependencies(bar 
	libbar)

add_subdirectory(test)