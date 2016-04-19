include(module)

function(install)
    # arguments:
    # NAME    name
    # MODULE  module
    # DEST    destination

    # parse arguments
    set(options)
    set(values  NAME MODULE DEST)
    cmake_parse_arguments(INSTALL "${options}" "${values}" "${lists}" "${ARGN}")
 
    add_custom_command(
        OUTPUT  ${INSTALL_DEST}
        COMMAND ${CMAKE_COMMAND} -E copy ${INSTALL_NAME} ${INSTALL_DEST}
        DEPENDS ${INSTALL_NAME}
        )

    add_custom_target(${INSTALL_NAME}.install
        ALL
        DEPENDS ${INSTALL_DEST}
        )

    if (INSTALL_MODULE)
        add_to_module(
            ${INSTALL_MODULE} 
            ${INSTALL_NAME}.install
            )
    endif()

endfunction()

