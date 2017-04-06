include_guard(__included_bin)
include(module)
include(install)
include(install_makefile)

function(bin)
    # - creates a binary
    #
    # arguments:
    # NAME     bin_name
    # MODULE   module
    # SRCS     sources*
    # PROTO    protobuf files*
    # LIBS     libraries*
    # TAG

    # parse arguments
    set(options TAG)
    set(values  NAME MODULE RPATH SUFFIX PROTO_CPP_OUT PROTO_CWD)
    set(lists   SRCS PROTO PROTO_INCLUDES LIBS)
    cmake_parse_arguments(ARG "${options}" "${values}" "${lists}" "${ARGN}")

    # if a target suffix hasn't been been specified, default to bin (tests build their binaries with a .test suffix)
    if(NOT ARG_SUFFIX)
        set(ARG_SUFFIX bin)
    endif()

    # all binaries have a suffix added, their name becomes a module to which they are added
    set(BIN_NAME ${ARG_NAME}.${ARG_SUFFIX})

    if (DEBUG_CMAKE)
        message(STATUS "BIN: NAME=${ARG_NAME} SUFFIX=${ARG_SUFFIX} BIN_NAME=${BIN_NAME} MODULE=${ARG_MODULE} PROTO=${ARG_PROTO} PROTO_INCLUDES=${ARG_PROTO_INCLUDES} PROTO_CPP_OUT=${ARG_PROTO_CPP_OUT} PROTO_CWD=${ARG_PROTO_CWD} LIBS=${ARG_LIBS} TAG=${ARG_TAG} SRCS=${ARG_SRCS} RPATH=${ARG_RPATH}")
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

          set(PROTO_LIB ${LIB_PROTOBUF})

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

    add_executable(${BIN_NAME}
        ${ARG_SRCS} ${PROTO_SRCS} ${PROTO_HDRS} ${ARG_MOC_OUT} ${ARG_RES_OUT} ${ARG_UI_OUT}
        )

    if (ARG_LIBS)
        clean_link_libs(ARG_LIBS_OUT "${ARG_LIBS}")
        target_link_libraries(${BIN_NAME} ${ARG_LIBS_OUT})
    endif()

    target_link_libraries(${BIN_NAME}
        ${PROTO_LIB}
        pthread
        rt
        )

    # don't link tcmalloc in debug builds, it can hide memory leaks from valgrind
    if (NOT CMAKE_BUILD_TYPE STREQUAL "Debug")
        target_link_libraries(${BIN_NAME}
            ${LIB_TCMALLOC}
            )
    endif()

    if(ARG_RPATH)
        set_target_properties(${BIN_NAME} PROPERTIES LINK_FLAGS "-Wl,-rpath,${ARG_RPATH}")
    endif()

    # add bin as a dependency of module, so 'make module' will build the bin
    add_to_module(
        ${ARG_NAME}
        ${BIN_NAME}
        )

    # if parent module has been specified, add this module to the parent
    if(ARG_MODULE)
        add_to_module(
            ${ARG_MODULE}
            ${ARG_NAME}
            )
    endif()

    # install the binary, and optionally a tagged binary, if requested
    if(ARG_TAG)
        set(TAG "TAG")
    endif()

    install(
        FILE
            ${CMAKE_CURRENT_BINARY_DIR}/${BIN_NAME}

        MODULE
            ${ARG_NAME}

        DEST
            ${CMAKE_CURRENT_SOURCE_DIR}/${ARG_NAME}

        ${TAG}
        )

    install_makefile()

    add_dependencies(${BIN_NAME} build_config)
endfunction()
