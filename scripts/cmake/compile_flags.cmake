include_guard(__included_compile_flags)
include(default_build)

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
add_flag       (-Wno-unused-parameter)
add_flag       (-Wno-maybe-uninitialized) # maybe-uninitialized is imperfect and reports false positives
#add_flag       (-Wno-strict-aliasing)     # libev breaks strict-aliasing rules
add_flag       (-pthread)
add_linker_flag(-m64)
add_linker_flag(-rdynamic)                 # required for backtrace

# TODO: libtins leaks memory
# if (CMAKE_COMPILER_IS_GNUCC AND CMAKE_CXX_COMPILER_VERSION VERSION_GREATER 5.1)
#     add_flag   (-fsanitize=leak)
#     add_flag   (-fno-omit-frame-pointer)
# endif()

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

if (CMAKE_BUILD_TYPE STREQUAL "Debug")
    message(STATUS "${CMAKE_BUILD_TYPE} build: CXX_FLAGS:${CMAKE_CXX_FLAGS}${CMAKE_CXX_FLAGS_DEBUG}")
    message(STATUS "${CMAKE_BUILD_TYPE} build: LINKER_FLAGS:${CMAKE_EXE_LINKER_FLAGS}${CMAKE_EXE_LINKER_FLAGS_DEBUG}")
else()
    message(STATUS "${CMAKE_BUILD_TYPE} build: CXX_FLAGS:${CMAKE_CXX_FLAGS}${CMAKE_CXX_FLAGS_RELEASE}")
    message(STATUS "${CMAKE_BUILD_TYPE} build: LINKER_FLAGS:${CMAKE_EXE_LINKER_FLAGS}${CMAKE_EXE_LINKER_FLAGS_RELEASE}")
endif()

############### CFLAGS #############

macro(add_cflag FLAG)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${FLAG}" )
endmacro()

macro(add_debug_cflag FLAG)
    set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} ${FLAG}" )
endmacro()

macro(add_release_cflag FLAG)
    set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} ${FLAG}" )
endmacro()

set(CMAKE_C_FLAGS "")
set(CMAKE_C_FLAGS_DEBUG "")
set(CMAKE_C_FLAGS_RELEASE "")

##########################################################################
# global
##########################################################################

add_cflag       (-Werror)
add_cflag       (-Wall)
add_cflag       (-Wextra)
add_cflag       (-m64)
add_cflag       (-msse2)
add_cflag       (-msse4.2)
add_cflag       (-mfpmath=sse)
add_cflag       (-Wno-unused-parameter)
add_cflag       (-Wno-maybe-uninitialized) # maybe-uninitialized is imperfect and reports false positives
#add_cflag       (-Wno-strict-aliasing)     # libev breaks strict-aliasing rules
add_cflag       (-pthread)

##########################################################################
# debug mode
##########################################################################

add_debug_cflag(-g)
add_debug_cflag(-ggdb3)
add_debug_cflag(-O0)
add_debug_cflag(-fno-inline)

##########################################################################
# release mode
##########################################################################

add_release_cflag(-ggdb1)
add_release_cflag(-DNDEBUG)
add_release_cflag(-O3)
add_release_cflag(-funroll-loops)
add_release_cflag(-fdevirtualize)
add_release_cflag(-finline-functions)
add_release_cflag(-fno-builtin-malloc)
add_release_cflag(-fno-builtin-calloc)
add_release_cflag(-fno-builtin-realloc)
add_release_cflag(-fno-builtin-free)
