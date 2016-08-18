include_guard(__included_protoc)

function(protoc SRCS HDRS GEN_PATHS)

    set(options)
    set(values    CPP_OUT CWD)
    set(lists     INCLUDE PROTO)
    cmake_parse_arguments(PROTOC "${options}" "${values}" "${lists}" "${ARGN}")

    if (NOT PROTOC_CPP_OUT)
        set(PROTOC_CPP_OUT ${CMAKE_CURRENT_SOURCE_DIR})
    endif()

    if (NOT PROTOC_CWD)
        set(PROTOC_CWD ${CMAKE_CURRENT_SOURCE_DIR})
    endif()

    if (NOT PROTOC_INCLUDE)
        set(PROTOC_INCLUDE ${CMAKE_CURRENT_SOURCE_DIR})
    endif()

    foreach(PATH ${PROTOC_INCLUDE})
        list(FIND _protobuf_include_path ${PATH} _contains_already)
        if(${_contains_already} EQUAL -1)
                list(APPEND _protobuf_include_path -I ${PATH})
        endif()
    endforeach()

    set(${SRCS})
    set(${HDRS})
    set(${GEN_PATHS})

    foreach(FILE ${PROTOC_PROTO})

        get_filename_component(ABS_FILE ${FILE} ABSOLUTE)

        # convert path of input file into path of output file
        string(REPLACE ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR} BIN_DEST ${ABS_FILE})

        get_filename_component(FILE_DEST ${BIN_DEST} DIRECTORY)
        get_filename_component(FILE_WE   ${BIN_DEST} NAME_WE)

        list(APPEND ${SRCS} "${FILE_DEST}/${FILE_WE}.pb.cc")
        list(APPEND ${HDRS} "${FILE_DEST}/${FILE_WE}.pb.h")

        list(FIND GEN_PATHS ${FILE_DEST} _contains_already)
        if(${_contains_already} EQUAL -1)
                list(APPEND GEN_PATHS ${FILE_DEST})
        endif()

        add_custom_command(
            OUTPUT
                "${FILE_DEST}/${FILE_WE}.pb.cc"
                "${FILE_DEST}/${FILE_WE}.pb.h"
            COMMAND
                ${PROTOBUF_PROTOC_EXECUTABLE}
            ARGS
                --cpp_out ${PROTOC_CPP_OUT} ${_protobuf_include_path} ${ABS_FILE}
            WORKING_DIRECTORY
                ${PROTOC_CWD}
            DEPENDS
                ${ABS_FILE}
                ${PROTOBUF_PROTOC_EXECUTABLE}
            COMMENT
                "Running C++ protocol buffer compiler on ${FILE}"
            VERBATIM
            )
    endforeach()

    set_source_files_properties(${${SRCS}} ${${HDRS}} PROPERTIES GENERATED TRUE)

    set(${SRCS}      ${${SRCS}} PARENT_SCOPE)
    set(${HDRS}      ${${HDRS}} PARENT_SCOPE)
    set(${GEN_PATHS} ${${GEN_PATHS}} PARENT_SCOPE)

endfunction()
