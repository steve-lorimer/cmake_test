include(qt)
include(module)
include(install)

function(qt_bin)
    # - creates a qt binary 
    # - optionally adds the binary to 'module' target
    # - optionally installs the binary
    # - optionally installs a tagged binary
    #
    # arguments:
    # NAME   bin_name
    # SRCS   sources*
    # DEPS   dependencies*
    # MOC    mocable_headers*
    # RES    qt_resources*
    # UI     qt_ui_files*
    # MODULE module
    # INSTALL 
    # TAG

    # parse arguments
    set(options INSTALL TAG)
    set(values  NAME MODULE)
    set(lists   SRCS DEPS MOC RES UI)
    cmake_parse_arguments(BIN "${options}" "${values}" "${lists}" "${ARGN}")

    require_qt5()

    # qt specific helpers
    if(BIN_MOC)
        qt5_wrap_cpp(BIN_MOC_OUT ${BIN_MOC})
    endif()

    if(BIN_RES)
        qt5_add_resources(BIN_RES_OUT ${BIN_RES})
    endif()

    if(BIN_UI)
        qt5_wrap_ui(BIN_UI_OUT ${BIN_UI})
    endif()

    add_executable       (${BIN_NAME} ${BIN_SRCS} ${BIN_MOC_OUT} ${BIN_RES_OUT} ${BIN_UI_OUT})
    target_link_libraries(${BIN_NAME} ${BIN_DEPS} Qt5::Widgets)

    # install the binary, and optionally a tagged binary, if requested
    if(BIN_INSTALL)
        if(BIN_TAG)
            set(TAG "TAG")
        endif()

        install(
            FILE   ${BIN_NAME}
            MODULE ${BIN_MODULE}
            DEST   ${CMAKE_CURRENT_SOURCE_DIR}/${BIN_NAME}
            ${TAG}
            )
    endif()

    # add binary as a dependency of module, so 'make module' will build the lib
    if(BIN_MODULE)
        add_to_module(
            ${BIN_MODULE} 
            ${BIN_NAME}
            )
    endif()

endfunction()

