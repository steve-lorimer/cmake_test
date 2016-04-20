lib(
	NAME   libbar
	STATIC
	MODULE bar
	SRCS   bar.cpp
	LIBS   libfoo
	)

add_subdirectory(test)