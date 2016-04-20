if(__included_install)
    return()
endif()
set(__included_install YES)

include(module)
include(version)

function(install)
    # arguments:
    # FILE    file
    # MODULE  module
    # DEST    destination
    # TAG

    # parse arguments
    set(options TAG)
    set(values  FILE MODULE DEST)
    set(lists)
    cmake_parse_arguments(INSTALL "${options}" "${values}" "${lists}" "${ARGN}")

    # variable which hold a list of all installed targets
    set(INSTALL_TARGETS ${INSTALL_DEST})

    # install the file
    add_custom_command(
        OUTPUT  ${INSTALL_DEST}
        COMMAND ${CMAKE_COMMAND} -E copy ${INSTALL_FILE} ${INSTALL_DEST}
        DEPENDS ${INSTALL_FILE}
        )

    # install a tagged file if requested
    if(INSTALL_TAG)
        version_tag(TAG)
        set(TAGGED_INSTALL_FILE ${INSTALL_DEST}.${TAG})

        add_custom_command(
            OUTPUT  ${TAGGED_INSTALL_FILE}
            COMMAND ${CMAKE_SOURCE_DIR}/scripts/rm_tagged_output.sh ${INSTALL_DEST} short
            COMMAND ${CMAKE_COMMAND} -E copy ${INSTALL_FILE} ${TAGGED_INSTALL_FILE}
            DEPENDS ${INSTALL_FILE}
            )

        set(INSTALL_TARGETS "${INSTALL_TARGETS} ${TAGGED_INSTALL_FILE}")
    endif()

    # make clean will remove the installed file
    set_directory_properties(
        PROPERTIES
        ADDITIONAL_MAKE_CLEAN_FILES
        ${INSTALL_TARGETS})

    # required for add_custom_target
    separate_arguments(INSTALL_TARGETS)

    # add an install target to ALL
    add_custom_target(${INSTALL_FILE}.install
        ALL
        DEPENDS ${INSTALL_TARGETS}
        )

    # if this is part of a module, add the install step to it
    if(INSTALL_MODULE)
        add_to_module(
            ${INSTALL_MODULE} 
            ${INSTALL_FILE}.install
            )
    endif()

endfunction()

