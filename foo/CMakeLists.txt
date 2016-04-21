lib(
	NAME   libfoo
	STATIC
	MODULE foo
	SRCS   foo.cpp
    LIBS   eastl
	)

add_subdirectory(test)
