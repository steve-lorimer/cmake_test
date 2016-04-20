if(__included_settings)
    return()
endif()
set(__included_settings YES)

# favour static libs over shared
set(CMAKE_FIND_LIBRARY_SUFFIXES .a ${CMAKE_FIND_LIBRARY_SUFFIXES})

