add_library(libbar STATIC 
	bar.cpp
	)

target_link_libraries(libbar libfoo)

add_to_module(bar libbar)

add_subdirectory(test)