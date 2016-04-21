include_guard(__included_compile_flags)

# helper macros for setting flags

macro(add_flag FLAG)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${FLAG}" )
endmacro()

macro(add_debug_flag FLAG)
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} ${FLAG}" )
endmacro()

macro(add_release_flag FLAG)
    set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} ${FLAG}" )
endmacro()

macro(add_linker_flag FLAG)
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${FLAG}" )
endmacro()

macro(add_debug_linker_flag FLAG)
    set(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG} ${FLAG}" )
endmacro()

macro(add_release_linker_flag FLAG)
    set(CMAKE_EXE_LINKER_FLAGS_RELEASE "${CMAKE_EXE_LINKER_FLAGS_RELEASE} ${FLAG}" )
endmacro()

# reset all flags before adding our own, so we don't inadvertently get something cmake sets by default

set(CMAKE_CXX_FLAGS "")
set(CMAKE_CXX_FLAGS_DEBUG "")
set(CMAKE_CXX_FLAGS_RELEASE "")
set(CMAKE_EXE_LINKER_FLAGS "")
set(CMAKE_EXE_LINKER_FLAGS_DEBUG "")
set(CMAKE_EXE_LINKER_FLAGS_RELEASE "")

##########################################################################
# global
##########################################################################

add_flag       (-std=c++14)
add_flag       (-Werror)
add_flag       (-Wall)
add_flag       (-Wextra)
add_flag       (-m64)
add_flag       (-msse2)
add_flag       (-msse4.2)
add_flag       (-mfpmath=sse)
add_flag       (-ftemplate-depth-128)
add_linker_flag(-m64)
add_linker_flag(-rdynamic)                 # required for backtrace

##########################################################################
# debug mode
##########################################################################

add_debug_flag(-g)
add_debug_flag(-ggdb3)
add_debug_flag(-O0)
add_debug_flag(-fno-inline)

##########################################################################
# release mode
##########################################################################

add_release_flag(-ggdb1)
add_release_flag(-DNDEBUG)
add_release_flag(-O3)
add_release_flag(-funroll-loops)
add_release_flag(-fdevirtualize)
add_release_flag(-finline-functions)
add_release_flag(-fno-builtin-malloc)
add_release_flag(-fno-builtin-calloc)
add_release_flag(-fno-builtin-realloc)
add_release_flag(-fno-builtin-free)

##########################################################################

message(STATUS "CXX_FLAGS:${CMAKE_CXX_FLAGS}")
message(STATUS "DEBUG_CXX_FLAGS:${CMAKE_CXX_FLAGS_DEBUG}")
message(STATUS "RELEASE_CXX_FLAGS:${CMAKE_CXX_FLAGS_RELEASE}")
message(STATUS "LINKER_FLAGS:${CMAKE_EXE_LINKER_FLAGS}")
message(STATUS "DEBUG_LINKER_FLAGS:${CMAKE_EXE_LINKER_FLAGS_DEBUG}")
message(STATUS "RELEASE_LINKER_FLAGS:${CMAKE_EXE_LINKER_FLAGS_RELEASE}")
