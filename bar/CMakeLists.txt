find_shared_lib(protobuf PROTOBUF)

message(STATUS "protobuf lib: ${PROTOBUF}")

lib(
	NAME   
        libbar
	STATIC
	MODULE
        bar
	SRCS   
        bar.cpp 
        message.pb.cc

	LIBS   
        libfoo 
        ${PROTOBUF}
	)

add_subdirectory(test)