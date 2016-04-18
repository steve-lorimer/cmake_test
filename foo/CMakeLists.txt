file(GLOB src "*.cpp")

# create a dummy top-level  target which all 'foo' related items will be added to
add_custom_target(foo
	ALL
	)

# add libfoo, and make it a dependency of dummy top-level target foo
add_library(libfoo STATIC ${src})
add_dependencies(foo 
	libfoo)

add_subdirectory(test)