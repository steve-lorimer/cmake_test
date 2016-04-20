include(qt)
include(bin)

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

    # create variables for passing on whether the user requested INSTALL and TAG
    if(BIN_INSTALL)
        
        set(INSTALL "INSTALL")

        if(BIN_TAG)
            set(TAG "TAG")
        endif()

    endif()

    # build the binary, linking in Qt5 widgets
    bin(
        NAME ${BIN_NAME}
        
        SRCS 
            ${BIN_SRCS} 
            ${BIN_MOC_OUT} 
            ${BIN_RES_OUT} 
            ${BIN_UI_OUT}

        DEPS 
            ${BIN_DEPS} 
            Qt5::Widgets

        ${INSTALL} ${TAG}
        )

endfunction()

