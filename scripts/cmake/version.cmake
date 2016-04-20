add_custom_target(
	version_info
    ALL
    COMMAND ${CMAKE_SOURCE_DIR}/scripts/version.sh ${CMAKE_SOURCE_DIR}
    )

