include(qt)

function(qt_bin)
    # - creates a qt binary 
    # - adds the binary to 'module' target
    # arguments:
    # NAME   bin_name
    # MODULE module
    # SRCS   sources*
    # DEPS   dependencies*
    # MOC    mocable_headers*
    # RES    qt_resources*
    # UI     qt_ui_files*

    # parse arguments
    set(options)
    set(values  NAME MODULE)
    set(lists   SRCS DEPS MOC RES UI)
    cmake_parse_arguments(BIN "${options}" "${values}" "${lists}" "${ARGN}")

    require_qt5()

    if (BIN_MOC)
        qt5_wrap_cpp(BIN_MOC_OUT ${BIN_MOC})
    endif()

    if (BIN_RES)
        qt5_add_resources(BIN_RES_OUT ${BIN_RES})
    endif()

    if (BIN_UI)
        qt5_wrap_ui(BIN_UI_OUT ${BIN_UI})
    endif()

    add_executable       (${BIN_NAME} ${BIN_SRCS} ${BIN_MOC_OUT} ${BIN_RES_OUT} ${BIN_UI_OUT})
    target_link_libraries(${BIN_NAME} ${BIN_DEPS} Qt5::Widgets)

    # add binary as a dependency of module, so 'make module' will build the lib
    if (BIN_MODULE)
        add_to_module(${BIN_MODULE} ${BIN_NAME})
    endif()

endfunction()

