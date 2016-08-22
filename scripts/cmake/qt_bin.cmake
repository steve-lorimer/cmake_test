include_guard(__included_qt_bin)
include(bin)

function(qt_bin)
    # - creates a qt binary 
    #
    # arguments:
    # NAME    bin_name
    # INSTALL install_name
    # MODULE  module
    # SRCS    sources*
    # PROTO   protobuf files*
    # LIBS    libraries*
    # DEPS    dependencies*
    # MOC     qt_mocable_headers*
    # RES     qt_resources*
    # UI      qt_ui_files*
    # TAG

    # parse arguments
    set(options TAG)
    set(values  NAME MODULE INSTALL)
    set(lists   SRCS PROTO LIBS DEPS MOC RES UI)
    cmake_parse_arguments(BIN "${options}" "${values}" "${lists}" "${ARGN}")

    if (DEBUG_CMAKE)
        message(STATUS "QT_BIN: NAME=${BIN_NAME} MODULE=${BIN_MODULE} PROTO=${BIN_PROTO} LIBS=${BIN_LIBS} DEPS=${BIN_DEPS} MOC=${BIN_MOC} RES=${BIN_RES} UI=${BIN_UI} INSTALL=${BIN_INSTALL} TAG=${BIN_TAG}")
    endif()

    # qt specific helpers
    if(NOT NO_GUI)
        if(BIN_MOC)
            qt5_wrap_cpp(BIN_MOC_OUT ${BIN_MOC})
        endif()

        if(BIN_RES)
            qt5_add_resources(BIN_RES_OUT ${BIN_RES})
        endif()

        if(BIN_UI)
            qt5_wrap_ui(BIN_UI_OUT ${BIN_UI})
        endif()
    endif()
    
    # create variables for passing on whether the user requested INSTALL and TAG
    if(BIN_INSTALL)
        
        # set(INSTALL "INSTALL ${BIN_INSTALL}")

        if(BIN_TAG)
            set(TAG "TAG")
        endif()
    endif()

    bin(
        NAME 
            ${BIN_NAME}
        
        MODULE
            ${BIN_MODULE}

        SRCS 
            ${BIN_SRCS} 
            ${BIN_MOC_OUT} 
            ${BIN_RES_OUT} 
            ${BIN_UI_OUT}

        PROTO
            ${BIN_PROTO}

        LIBS 
            ${BIN_LIBS} 

        DEPS
            ${BIN_DEPS}

        INSTALL
            ${BIN_INSTALL} 

        ${TAG}
        )

endfunction()

