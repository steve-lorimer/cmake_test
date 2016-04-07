cmake_minimum_required (VERSION 2.8.12)
project (cmake_test)

if (NOT CMAKE_BUILD_TYPE)
	set(CMAKE_BUILD_TYPE "Debug")
endif()

add_subdirectory (lib1)
#add_subdirectory (lib2)


set (CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG   ${CMAKE_BINARY_DIR}/.build/${CMAKE_BUILD_TYPE}/lib)
set (CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG   ${CMAKE_BINARY_DIR}/.build/${CMAKE_BUILD_TYPE}/lib)
set (CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG   ${CMAKE_BINARY_DIR}/.build/${CMAKE_BUILD_TYPE}/bin)
set (CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/.build/${CMAKE_BUILD_TYPE}/lib)
set (CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/.build/${CMAKE_BUILD_TYPE}/lib)
set (CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/.build/${CMAKE_BUILD_TYPE}/bin)

link_directories (${link_directories} ${CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG}) 
link_directories (${link_directories} ${CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE}) 

include_directories ("${PROJECT_SOURCE_DIR}")

# Qt library
#message (STATUS "Qt5 is used")
#find_package(Qt5Core    REQUIRED)
#find_package(Qt5Widgets REQUIRED)
#find_package(Qt5OpenGL  REQUIRED)
#ADD_DEFINITIONS(${Qt5Widgets_DEFINITIONS})
#INCLUDE_DIRECTORIES(${INCLUDE_DIRECTORIES} 
#	  ${QT_INCLUDES}
#	  ${QT_INCLUDE_DIR}
#	  ${QT_QT_INCLUDE_DIR}
#	  ${QT_QTCORE_INCLUDE_DIR}
#	  ${QT_QTGUI_INCLUDE_DIR}
#	  ${QT_QTOPENGL_INCLUDE_DIR}
#	  ${Qt5Widgets_INCLUDE_DIRS}
#	  )

find_package(Boost) 
if (Boost_FOUND)
    include_directories (${Boost_INCLUDE_DIRS}) 
endif()	  

if ("${CMAKE_BUILD_TYPE}" MATCHES "Debug")
	if (CMAKE_COMPILER_IS_GNUCXX)
    	set_property (DIRECTORY APPEND PROPERTY COMPILE_DEFINITIONS $<$<CONFIG:Debug>:_DEBUG> )
  	endif()
endif()

if (CMAKE_COMPILER_IS_GNUCXX)
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++11")
endif()