include_guard(__included_project)

function(default_project PROJECT_NAME)
    if(NOT BUILD_PROJECT)
        set(BUILD_PROJECT "${PROJECT_NAME}" PARENT_SCOPE)
    elseif(NOT EXISTS ${CMAKE_SOURCE_DIR}/projects/${BUILD_PROJECT}.cmake)
        message(FATAL_ERROR "Unknown project \"${BUILD_PROJECT}\"")
    endif()
endfunction()

function(add_project PROJECT_NAME)
    if(BUILD_PROJECT STREQUAL "${PROJECT_NAME}")

        message(TRACE "[ building ${PROJECT_NAME} ]")
        include(${PROJECT_NAME})

    endif()
endfunction()
