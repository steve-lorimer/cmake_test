lib(
    NAME   foo
    STATIC
    SRCS   foo.cpp
    PROTO  foo_msg.proto
    LIBS   eastl.lib
    )

add_subdirectory(test)
