include_guard(__included_version)

add_custom_target(
	version_info
    ALL
    COMMAND ${CMAKE_SOURCE_DIR}/scripts/version.sh ${CMAKE_SOURCE_DIR}
    )

function(version_tag TAG)

    execute_process(
        OUTPUT_VARIABLE  OUTPUT
        COMMAND          ${CMAKE_SOURCE_DIR}/scripts/tag.sh ${CMAKE_SOURCE_DIR}
        OUTPUT_STRIP_TRAILING_WHITESPACE
        )

    set(${TAG} ${OUTPUT} PARENT_SCOPE)

endfunction()

