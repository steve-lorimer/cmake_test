add_custom_target(
    build_config
    ALL
    DEPENDS
        build_config.command
    )

add_custom_command(
    OUTPUT
        build_config.command
    COMMAND
        ${CMAKE_COMMAND}
            -DCMAKE_MODULE_PATH=${CMAKE_SCRIPTS_DIR}
            -DCMAKE_SCRIPTS_DIR=${CMAKE_SCRIPTS_DIR}
            -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
            -DCMAKE_CXX_COMPILER_ID=${CMAKE_CXX_COMPILER_ID}
            -P ${CMAKE_SCRIPTS_DIR}/print_build_config.cmake
    )
