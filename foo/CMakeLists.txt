file(GLOB src "*.cpp")

add_library(_foo STATIC ${src})

add_custom_target(foo
	ALL
	)

add_dependencies(foo _foo)
add_subdirectory(test)