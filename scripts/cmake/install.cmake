include_guard(__included_install)
include(module)
include(version)
include(message)

function(install)
    # arguments:
    # FILE    file
    # MODULE  module
    # DEST    destination
    # DEPS    dependencies*
    # TAG

    # parse arguments
    set(options TAG)
    set(values  FILE MODULE DEST)
    set(lists   DEPS)
    cmake_parse_arguments(ARG "${options}" "${values}" "${lists}" "${ARGN}")

    if(DEBUG_CMAKE)
        message(STATUS "INSTALL: FILE=${ARG_FILE} MODULE=${ARG_MODULE} DEST=${ARG_DEST} TAG=${ARG_TAG} DEPS=${ARG_DEPS}")
    endif()

    get_filename_component(SRC_FILENAME ${ARG_FILE} NAME_WE)
    get_filename_component(ABS_SRC_FILE ${ARG_FILE} ABSOLUTE)

    get_filename_component(DST_FILENAME ${ARG_DEST} NAME_WE)
    get_filename_component(INSTALL_DIR  ${ARG_DEST} DIRECTORY)

    # sanity check - does a folder already exist with the same name as the destination file?
    if(IS_DIRECTORY ${ARG_DEST})
        message(FATAL_ERROR "Unable to install target with the same name as preexisting directory ${ARG_DEST}")
    endif()

    # install the file
    add_custom_command(
        OUTPUT
            ${ARG_DEST}

        COMMAND
            ${CMAKE_COMMAND} -E make_directory ${INSTALL_DIR}

        COMMAND
            ${CMAKE_COMMAND} -E copy ${ABS_SRC_FILE} ${ARG_DEST}

        COMMENT
            "Installing ${SRC_FILENAME}"

        DEPENDS
            ${ARG_FILE}
        )

    string(REPLACE ${CMAKE_SOURCE_DIR}/ "" FILE_STEM ${ARG_DEST})
    string(REPLACE "/" "." INSTALL_TARGET ${FILE_STEM})

    # variable which hold a list of installed targets (normal installed target and tagged installed target)
    set(INSTALLED_TARGETS ${ARG_DEST})

    # install a tagged file if requested
    if(ARG_TAG)

        add_custom_target(
            ${INSTALL_TARGET}.tag

            ALL

            COMMAND
                ${CMAKE_COMMAND}
                    -DSRC_FILE=${ABS_SRC_FILE}
                    -DDEST_FILE=${ARG_DEST}
                    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
                    -DCMAKE_MODULE_PATH=${CMAKE_SCRIPTS_DIR}
                    -P ${CMAKE_SCRIPTS_DIR}/install_tagged.cmake

            DEPENDS
                ${ARG_FILE}
        )

        set(INSTALLED_TARGETS "${INSTALLED_TARGETS} ${INSTALL_TARGET}.tag")
    endif()

    # make clean will remove the installed file
    set_directory_properties(
        PROPERTIES
        ADDITIONAL_MAKE_CLEAN_FILES
            ${INSTALL_DIR}/${ABS_SRC_FILE}.[0-9]*)

    # required for add_custom_target
    separate_arguments(INSTALLED_TARGETS)

    # add an install target to ALL
    add_custom_target(${INSTALL_TARGET}.install
        ALL
        DEPENDS
            ${INSTALLED_TARGETS}
        )

    if(ARG_DEPS)
        add_dependencies(${INSTALL_TARGET}.install ${ARG_DEPS})
    endif()

    # if we're installing to a location inside the source tree, ensure the installed binaries are
    # in a local .gitignore file
    string(FIND ${INSTALL_DIR} ${CMAKE_SOURCE_DIR} INSTALL_IS_IN_SRC)

    if(INSTALL_IS_IN_SRC GREATER -1)
        set(GITIGNORE_FILENAME ${INSTALL_DIR}/.gitignore)

        if(EXISTS ${GITIGNORE_FILENAME})
            file(READ ${GITIGNORE_FILENAME} GITIGNORE)
        endif()

        # search for the installed filename in the gitignore
        if(GITIGNORE)
            string(FIND ${GITIGNORE} ${DST_FILENAME} INSTALL_IS_IN_GITIGNORE)
        endif()

        if(NOT DEFINED INSTALL_IS_IN_GITIGNORE OR NOT INSTALL_IS_IN_GITIGNORE GREATER -1)
            file(APPEND ${GITIGNORE_FILENAME} "${DST_FILENAME}\n")
        endif()

        # if we're also installing tagged binaries, make sure a globbing pattern exists in gitignore too
        if (ARG_TAG)
            set(TAG_PATTERN "${DST_FILENAME}.[0-9]*")

            # search for the destination filename in the gitignore
            if(GITIGNORE)
                string(FIND ${GITIGNORE} ${TAG_PATTERN} INSTALL_TAG_IS_IN_GITIGNORE)
            endif()

            if(NOT DEFINED INSTALL_TAG_IS_IN_GITIGNORE OR NOT INSTALL_TAG_IS_IN_GITIGNORE GREATER -1)
                file(APPEND ${GITIGNORE_FILENAME} "${TAG_PATTERN}\n")
            endif()
        endif()
    endif()

    # if this is part of a module, add the install step to it
    if(ARG_MODULE)
        add_to_module(
            ${ARG_MODULE}
            ${INSTALL_TARGET}.install
        )
    endif()

endfunction()
