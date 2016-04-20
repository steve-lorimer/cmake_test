if(__included_qt)
    return()
endif()
set(__included_qt YES)

macro(require_qt5)

	find_package(Qt5Widgets REQUIRED)

	#set(CMAKE_INCLUDE_CURRENT_DIR ON) # qt generated files are put into the current build directory - so tell cmake where to find them

endmacro()
