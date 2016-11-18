include_guard(__included_lib)
include(module)
include(install)
include(install_makefile)

function(lib)
    # - creates a library
    #
    # arguments:
    # NAME           lib_name
    # [STATIC]/SHARED
    # MODULE         module
    # SRCS           sources*
    # PROTO          protobuf files*
    # PROTO_INCLUDES additional search paths passed to protoc
    # LIBS           dependencies*
    # TAG            also install tagged

    # parse arguments
    set(options STATIC SHARED TAG)
    set(values  NAME MODULE PROTO_CPP_OUT PROTO_CWD)
    set(lists   SRCS PROTO PROTO_INCLUDES LIBS MOC RES UI)
    cmake_parse_arguments(ARG "${options}" "${values}" "${lists}" "${ARGN}")

    # link type
    if(ARG_SHARED)
        set(LINK SHARED)

        # all shared libs have a .so suffix added, their name becomes a module to which they are added
        set(LIB_NAME ${ARG_NAME}.so)
    else()
        # default to STATIC if nothing is specified
        set(LINK STATIC)

        # all static libs have a .lib suffix added, their name becomes a module to which they are added
        set(LIB_NAME ${ARG_NAME}.lib)
    endif()

    if(DEBUG_CMAKE)
        message(STATUS "LIB: NAME=${ARG_NAME} LIB_NAME=${LIB_NAME} MODULE=${ARG_MODULE} PROTO=${ARG_PROTO} PROTO_INCLUDES=${ARG_PROTO_INCLUDES} PROTO_CPP_OUT=${ARG_PROTO_CPP_OUT} PROTO_CWD=${ARG_PROTO_CWD} LIBS=${ARG_LIBS} SRCS=${ARG_SRCS}")
    endif()

    # generate protobuf files if required
    if (ARG_PROTO)
        protoc(
            PROTO_SRCS
            PROTO_HDRS
            PROTO_DIRS

            PROTO
                ${ARG_PROTO}

            INCLUDE
                ${ARG_PROTO_INCLUDES}

            CPP_OUT
                ${ARG_PROTO_CPP_OUT}

            CWD
                ${ARG_PROTO_CWD}
            )

        if(NOT ARG_SHARED)
            set(PROTO_LIB ${LIB_PROTOBUF})
        endif()

    endif()

    if(NOT NO_GUI)
        # qt specific helpers
        if(ARG_MOC)
            qt5_wrap_cpp(ARG_MOC_OUT ${ARG_MOC})
        endif()

        if(ARG_RES)
            qt5_add_resources(ARG_RES_OUT ${ARG_RES})
        endif()

        if(ARG_UI)
            qt5_wrap_ui(ARG_UI_OUT ${ARG_UI})
        endif()
    endif()

    add_library(
        ${LIB_NAME}
        ${LINK}
        ${ARG_SRCS} ${PROTO_SRCS} ${PROTO_HDRS} ${ARG_MOC_OUT} ${ARG_RES_OUT} ${ARG_UI_OUT}
        )

    # Work around CMP0003: Libraries linked via full path no longer produce linker search paths
    # Don't link with absolute paths, just link using the library name, and add the path to the library
    #  search path
    set(LIB_FILES)
    set(LIB_DIRS)
    foreach(LIB ${ARG_LIBS})
        get_filename_component(FILE ${LIB} NAME)
        get_filename_component(DIR  ${LIB} DIRECTORY)

        # if this is an internal target, add the implicit .lib suffix
        if (TARGET ${FILE}.lib)
            add_unique(${FILE}.lib LIB_FILES)
        else()
            add_unique(${FILE} LIB_FILES)
        endif()

        if(DIR)
            add_unique(${DIR} LIB_DIRS)
        endif()
    endforeach()

    # Add any paths found in our libraries to the linker search path
    foreach(DIR ${LIB_DIRS})
        target_link_libraries(${LIB_NAME} -L${DIR})
    endforeach()

    target_link_libraries(${LIB_NAME}
        ${LIB_FILES}
        ${PROTO_LIB})

    # Add include paths for generated files so relative includes work
    # this is such a mess - there must be a better way to do this, but so far I haven't found one
    set(DIR_LIST)
    foreach(FILE ${ARG_SRCS})
        get_filename_component(ABS_FILE ${FILE}     ABSOLUTE)
        get_filename_component(DIR      ${ABS_FILE} DIRECTORY)
        add_unique(${DIR} DIR_LIST)
    endforeach()
    foreach(DIR ${PROTO_DIRS})
        add_unique(${DIR} DIR_LIST)
    endforeach()

    # current source directory is always implicitly searched for local includes, and if explicitly added
    #  it can hide system file
    list(REMOVE_ITEM DIR_LIST ${CMAKE_CURRENT_SOURCE_DIR})

    target_include_directories(${LIB_NAME} PRIVATE ${DIR_LIST})

    # remove the .so suffix we added to the target name from the generated library
    if(ARG_SHARED AND NOT WIN32)
        set_target_properties(${LIB_NAME} PROPERTIES OUTPUT_NAME ${ARG_NAME})
    endif()

    # add lib as a dependency of module, so 'make module' will build the lib
    add_to_module(
        ${ARG_NAME}
        ${LIB_NAME}
        )

    # if parent module has been specified, add this module to the parent
    if(ARG_MODULE)
        add_to_module(
            ${ARG_MODULE}
            ${ARG_NAME}
            )
    endif()

    install_makefile()

endfunction()

