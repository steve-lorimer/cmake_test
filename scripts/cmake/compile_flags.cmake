if(__included_compile_flags)
    return()
endif()
set(__included_compile_flags YES)

if (CMAKE_COMPILER_IS_GNUCXX)
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++14")
endif()
