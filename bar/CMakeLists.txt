lib(
    NAME
        bar_lib
    STATIC
    MODULE
        bar
    SRCS
        bar.cpp
    PROTO
        bar_msg.proto
    LIBS
        foo_lib
    )

add_subdirectory(test)
