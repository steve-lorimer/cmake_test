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
        ${PROTOBUF_LIBRARIES}
	)

add_subdirectory(test)