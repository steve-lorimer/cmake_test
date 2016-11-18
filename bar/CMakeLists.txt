lib(
    NAME
        bar
    STATIC
    SRCS
        bar.cpp
    PROTO
        bar_msg.proto
    LIBS
        foo.lib
    )

add_subdirectory(test)
