if(NOT BUILD_PROJECT)
    set(BUILD_PROJECT "project1")
endif()

function(add_project PROJECT_NAME)
    if(BUILD_PROJECT STREQUAL "${PROJECT_NAME}")
        include(${PROJECT_NAME})
    endif()
endfunction()

add_project(project1)
add_project(project2)
