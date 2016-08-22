include_guard(__included_install)

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
    cmake_parse_arguments(ARG "${options}" "${values}" "${lists}" "${ARGN}")

    get_filename_component(SRC_FILENAME ${ARG_FILE} NAME_WE)
    get_filename_component(ABS_SRC_FILE ${ARG_FILE} ABSOLUTE)
    get_filename_component(INSTALL_DIR  ${ARG_DEST} DIRECTORY)

    # install the file
    add_custom_command(
        OUTPUT  
            ${ARG_DEST}

        COMMAND 
            ${CMAKE_COMMAND} -E make_directory ${INSTALL_DIR}

        COMMAND 
            ${CMAKE_COMMAND} -E remove ${ARG_DEST}
        
        COMMAND 
            ${CMAKE_COMMAND} -E create_symlink ${ABS_SRC_FILE} ${ARG_DEST}
        
        COMMENT
            "Installing ${SRC_FILENAME}"

        DEPENDS 
            ${ARG_FILE}
        )

    # variable which hold a list of installed targets (normal installed target and tagged installed target)
    set(INSTALLED_TARGETS ${ARG_DEST})

    # install a tagged file if requested
    if(ARG_TAG)

        add_custom_target(
            ${SRC_FILENAME}.tag

            ALL
           
            COMMAND 
                ${CMAKE_COMMAND} -E make_directory ${INSTALL_DIR}

            COMMAND 
                ${BASH_EXECUTABLE} ${CMAKE_SOURCE_DIR}/scripts/install_tagged.sh ${ABS_SRC_FILE} ${ARG_DEST}
            
            DEPENDS 
                ${ARG_FILE}
            )

        set(INSTALLED_TARGETS "${INSTALLED_TARGETS} ${SRC_FILENAME}.tag")
    endif()

    # make clean will remove the installed file
    set_directory_properties(
        PROPERTIES
        ADDITIONAL_MAKE_CLEAN_FILES
        ${INSTALL_DIR})

    # required for add_custom_target
    separate_arguments(INSTALLED_TARGETS)

    # add an install target to ALL
    add_custom_target(${SRC_FILENAME}.install
        ALL
        DEPENDS 
            ${INSTALLED_TARGETS}
        )

    # if this is part of a module, add the install step to it
    if(ARG_MODULE)
        add_to_module(
            ${ARG_MODULE} 
            ${SRC_FILENAME}.install
            )
    endif()

endfunction()

