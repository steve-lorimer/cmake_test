lib(
	NAME   libbar
	STATIC
	MODULE bar
	SRCS   bar.cpp
	DEPS   libfoo
	)

add_subdirectory(test)