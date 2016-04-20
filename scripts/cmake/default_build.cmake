if(__included_default_build)
    return()
endif()
set(__included_default_build YES)

if (NOT CMAKE_BUILD_TYPE)
	set(CMAKE_BUILD_TYPE "Debug")
endif()


