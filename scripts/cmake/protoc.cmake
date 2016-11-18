include_guard(__included_protoc)

# Google's provided vcproj files generate libraries with a "lib" prefix on Windows
if(MSVC)
    set(PROTOBUF_ORIG_FIND_LIBRARY_PREFIXES "${CMAKE_FIND_LIBRARY_PREFIXES}")
    set(CMAKE_FIND_LIBRARY_PREFIXES "lib" "")

    find_path(PROTOBUF_SRC_ROOT_FOLDER protobuf.pc.in)
endif()

# Find the include directory
find_path(PROTOBUF_INCLUDE_DIR
    google/protobuf/service.h
    PATHS ${PROTOBUF_SRC_ROOT_FOLDER}/src
)

# Find the protoc compiler
find_program(PROTOBUF_PROTOC_EXECUTABLE
  NAMES
    protoc

  DOC
    "The Google Protocol Buffers Compiler"

  PATHS
    ${PROTOBUF_SRC_ROOT_FOLDER}/vsprojects/${_PROTOBUF_ARCH_DIR}Release
    ${PROTOBUF_SRC_ROOT_FOLDER}/vsprojects/${_PROTOBUF_ARCH_DIR}Debug
)

# These are internal variables, don't display them in cmake guis
mark_as_advanced(PROTOBUF_PROTOC_EXECUTABLE)
mark_as_advanced(PROTOBUF_INCLUDE_DIR)

function(protoc SRCS_OUT HDRS_OUT DIRS_OUT)

    set(options)
    set(values  CPP_OUT CWD)
    set(lists    INCLUDE PROTO)
    cmake_parse_arguments(ARG "${options}" "${values}" "${lists}" "${ARGN}")

    if (NOT ARG_CPP_OUT)
        set(ARG_CPP_OUT ${CMAKE_SOURCE_DIR})
    endif()

    if (NOT ARG_CWD)
        set(ARG_CWD ${CMAKE_SOURCE_DIR})
    endif()

    set(PROTOC_INCLUDE_PATHS -I ${ARG_CWD})

    foreach(PATH ${ARG_INCLUDE})
        list(FIND PROTOC_INCLUDE_PATHS ${PATH} exists)
        if(${exists} EQUAL -1)
            list(APPEND PROTOC_INCLUDE_PATHS -I ${PATH})
        endif()
    endforeach()

    if(DEBUG_CMAKE)
        message(STATUS "PROTOC: INCLUDE=${ARG_INCLUDE} PROTO=${ARG_PROTO} CPP_OUT=${ARG_CPP_OUT} CWD=${ARG_CWD}")
    endif()

    set(GENERATED_SRCS)
    set(GENERATED_HDRS)
    set(GENERATED_DIRS)

    foreach(FILE ${ARG_PROTO})

        get_filename_component(ABS_FILE ${FILE} ABSOLUTE)

        string(REPLACE ${ARG_CWD} ${ARG_CPP_OUT} PROTO_DEST ${ABS_FILE})

        get_filename_component(FILE_WE  ${PROTO_DEST} NAME_WE)
        get_filename_component(DEST_DIR ${PROTO_DEST} DIRECTORY)

        list(FIND GENERATED_DIRS ${DEST_DIR} exists)
        if(${exists} EQUAL -1)
            list(APPEND GENERATED_DIRS ${DEST_DIR})
        endif()

        set(GENERATED_SRC "${DEST_DIR}/${FILE_WE}.pb.cc")
        set(GENERATED_HDR "${DEST_DIR}/${FILE_WE}.pb.h")

        add_custom_command(
            OUTPUT
                ${GENERATED_SRC}
                ${GENERATED_HDR}

            COMMAND
                ${PROTOBUF_PROTOC_EXECUTABLE}

            ARGS
                --cpp_out ${ARG_CPP_OUT} ${PROTOC_INCLUDE_PATHS} ${ABS_FILE}

            WORKING_DIRECTORY
                ${ARG_CWD}

            DEPENDS
                ${ABS_FILE}
                ${PROTOBUF_PROTOC_EXECUTABLE}

            COMMENT
                "Running C++ protocol buffer compiler on ${FILE}"

            VERBATIM
            )

        set_source_files_properties(${GENERATED_SRC} PROPERTIES GENERATED TRUE)
        set_source_files_properties(${GENERATED_HDR} PROPERTIES GENERATED TRUE)

        list(APPEND GENERATED_SRCS ${GENERATED_SRC})
        list(APPEND GENERATED_HDRS ${GENERATED_HDR})

    endforeach()

    if(DEBUG_CMAKE)
        message(STATUS "PROTOC: GENERATED_SRCS=${GENERATED_SRCS} GENERATED_HDRS=${GENERATED_HDRS} GENERATED_DIRS=${GENERATED_DIRS}")
    endif()

    set(${SRCS_OUT} ${GENERATED_SRCS} PARENT_SCOPE)
    set(${HDRS_OUT} ${GENERATED_HDRS} PARENT_SCOPE)
    set(${DIRS_OUT} ${GENERATED_DIRS} PARENT_SCOPE)

endfunction()

