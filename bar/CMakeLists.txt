lib(
	NAME   
        libbar
	STATIC
	MODULE
        bar
	SRCS   
        bar.cpp 
    PROTO
        message.proto
	LIBS   
        libfoo 
	)

add_subdirectory(test)