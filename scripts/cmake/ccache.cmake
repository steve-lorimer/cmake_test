if(__included_ccache)
    return()
endif()
set(__included_ccache YES)

# enable ccache if it exsts
find_program(CCACHE_FOUND ccache)

if(CCACHE_FOUND)
    message (STATUS "using ccache")
    set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE ccache)
    set_property(GLOBAL PROPERTY RULE_LAUNCH_LINK ccache)
endif(CCACHE_FOUND)

