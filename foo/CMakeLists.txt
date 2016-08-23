lib(
    NAME   foo_lib
    STATIC
    MODULE foo
    SRCS   foo.cpp
    PROTO  foo_msg.proto
    LIBS   eastl
    )

add_subdirectory(test)
