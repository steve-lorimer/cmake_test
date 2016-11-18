include_guard(__included_version)

function(create_version PURPOSE DEST_FILE)

    get_filename_component(DEST_FILE ${DEST_FILE} ABSOLUTE)

    add_custom_target(
        version_info.${PURPOSE}
        ALL
        COMMAND
            ${CMAKE_COMMAND}
                -DCMAKE_MODULE_PATH=${CMAKE_SCRIPTS_DIR}
                -DCMAKE_SCRIPTS_DIR=${CMAKE_SCRIPTS_DIR}
                -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
                -DPURPOSE=${PURPOSE}
                -DDEST_FILE=${DEST_FILE}
                -P ${CMAKE_SCRIPTS_DIR}/create_version.cmake
                )

    set_source_files_properties(${DEST_FILE} PROPERTIES GENERATED TRUE)

endfunction()
