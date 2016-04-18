file(GLOB src "*.cpp")

add_library(_lib1 STATIC ${src})

add_custom_target(lib1
	ALL
	)

add_dependencies(lib1 _lib1)
add_subdirectory(test)