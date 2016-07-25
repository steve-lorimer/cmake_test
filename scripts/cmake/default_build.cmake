include_guard(__included_default_build)

if (NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Debug")
endif()

if (NOT CMAKE_BUILD_TYPE STREQUAL "Debug" AND NOT CMAKE_BUILD_TYPE STREQUAL "Release")
    message(SEND_ERROR "Unknown build type: ${CMAKE_BUILD_TYPE}")    
endif()



