file(GLOB src "*.cpp")

add_library(libfoo STATIC ${src})

add_custom_target(foo
	ALL
	)

add_dependencies(foo libfoo)
add_subdirectory(test)