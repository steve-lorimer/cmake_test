include_guard(__included_protoc)

function(protoc SRCS)

    set(options)
    set(values    CPP_OUT CWD)
    set(lists     INCLUDE PROTO)
    cmake_parse_arguments(PROTOC "${options}" "${values}" "${lists}" "${ARGN}")

    if (NOT PROTOC_CPP_OUT)
        set(PROTOC_CPP_OUT ${CMAKE_SOURCE_DIR})
    endif()

    if (NOT PROTOC_CWD)
        set(PROTOC_CWD ${CMAKE_SOURCE_DIR})
    endif()

    if (NOT PROTOC_INCLUDE)
        set(PROTOC_INCLUDE ${CMAKE_SOURCE_DIR})
    endif()

    foreach(PATH ${PROTOC_INCLUDE})
        list(FIND PROTOC_INCLUDE_PATHS ${PATH} _contains_already)
        if(${_contains_already} EQUAL -1)
                list(APPEND PROTOC_INCLUDE_PATHS -I ${PATH})
        endif()
    endforeach()

    # if(DEBUG_CMAKE)
        message(STATUS "PROTOC: CPP_OUT=${PROTOC_CPP_OUT} CWD=${PROTOC_CWD} INCLUDE=${PROTOC_INCLUDE} PROTO=${PROTOC_PROTO}")
    # endif()

    set(${SRCS})
    set(HDRS)

    foreach(FILE ${PROTOC_PROTO})

        get_filename_component(ABS_FILE ${FILE} ABSOLUTE)

        # convert path of input file into path of output file
        set(BIN_DEST ${ABS_FILE})

        get_filename_component(FILE_DEST ${BIN_DEST} DIRECTORY)
        get_filename_component(FILE_WE   ${BIN_DEST} NAME_WE)

        message(STATUS "FILE_DEST: ${FILE_DEST}")
        message(STATUS "FILE_WE: ${FILE_WE}")
        message(STATUS "SRC: ${FILE_DEST}/${FILE_WE}.pb.cc")

        list(APPEND ${SRCS} "${FILE_DEST}/${FILE_WE}.pb.cc")
        list(APPEND HDRS    "${FILE_DEST}/${FILE_WE}.pb.h")

        add_custom_command(
            OUTPUT
                "${FILE_DEST}/${FILE_WE}.pb.cc"
                "${FILE_DEST}/${FILE_WE}.pb.h"
            COMMAND
                ${PROTOBUF_PROTOC_EXECUTABLE}
            ARGS
                --cpp_out ${PROTOC_CPP_OUT} ${PROTOC_INCLUDE_PATHS} ${ABS_FILE}
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

    set_source_files_properties(${${SRCS}} ${HDRS} PROPERTIES GENERATED TRUE)

    # if(DEBUG_CMAKE)
        message(STATUS "PROTOC: SRCS=${${SRCS}} HDRS=${HDRS}")
    # endif()

    set(${SRCS} ${${SRCS}} PARENT_SCOPE)

endfunction()

find_program(PROTOBUF_PROTOC_EXECUTABLE
    NAMES protoc
    DOC "The Google Protocol Buffers Compiler"
    PATHS
    ${PROTOBUF_SRC_ROOT_FOLDER}/vsprojects/${_PROTOBUF_ARCH_DIR}Release
    ${PROTOBUF_SRC_ROOT_FOLDER}/vsprojects/${_PROTOBUF_ARCH_DIR}Debug
)
mark_as_advanced(PROTOBUF_PROTOC_EXECUTABLE)
