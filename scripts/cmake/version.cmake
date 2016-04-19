add_custom_target(
	version_info
    ALL
    COMMAND ${CMAKE_SOURCE_DIR}/app/version.sh ${CMAKE_SOURCE_DIR}
    )

