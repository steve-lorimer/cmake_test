include_guard(__included_ccache)

# if ccache is found on the path, build through it

find_program(CCACHE_FOUND ccache)

if (NO_CCACHE)
    return()
endif()

if (CCACHE_FOUND)

    message (STATUS "using ccache")

    set_property(
        GLOBAL PROPERTY
            RULE_LAUNCH_COMPILE
                ccache
        )

    set_property(
        GLOBAL PROPERTY
            RULE_LAUNCH_LINK
                ccache
        )

endif()
