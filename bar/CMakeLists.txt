lib(
    NAME
        libbar
    STATIC
    MODULE
        bar
    SRCS
        bar.cpp
    PROTO
        bar_msg.proto
    LIBS
        libfoo
    )

add_subdirectory(test)
