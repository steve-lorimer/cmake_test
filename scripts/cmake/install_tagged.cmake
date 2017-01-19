include(message)

if(NOT SRC_FILE)
    message(FATAL_ERROR "no input file specified")
endif()

if(NOT EXISTS ${SRC_FILE})
    message(FATAL_ERROR "input file ${SRC_FILE} doesn't exist")
endif()

if(NOT DEST_FILE)
    message(FATAL_ERROR "no output file specified")
endif()

get_filename_component(INSTALL_DIR ${DEST_FILE} DIRECTORY)

# number of commits
execute_process(
    OUTPUT_VARIABLE   COMMITS
    COMMAND           git rev-list HEAD
    COMMAND           wc -l
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    OUTPUT_STRIP_TRAILING_WHITESPACE
    )

# branch name
execute_process(
    OUTPUT_VARIABLE   BRANCH
    COMMAND           git rev-parse --abbrev-ref HEAD
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    OUTPUT_STRIP_TRAILING_WHITESPACE
    )

# dirty tag
execute_process(
    OUTPUT_VARIABLE   DIRTY
    COMMAND           git diff --shortstat
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    OUTPUT_STRIP_TRAILING_WHITESPACE
    )

# build variant
string(TOLOWER ${CMAKE_BUILD_TYPE} BUILD)

if(BRANCH STREQUAL "master")
    unset(BRANCH)
else()
    set(BRANCH .${BRANCH})
endif()

if(BUILD STREQUAL "release")
    unset(BUILD)
else()
    set(BUILD .${BUILD})
endif()

if(DIRTY)
    set(DIRTY .dirty)
endif()

file(GLOB EXISTING_TAGGED_FILES ${DEST_FILE}*.[0-9]*)

set(TAGGED_DEST_FILE ${DEST_FILE}${BRANCH}.${COMMITS}${BUILD}${DIRTY})

# default install operation is to to create a symlink, as this uses the least amount of disk space
# - allow users to copy the file, at the expense of additional space
if(INSTALL_TAGGED_AS_COPY)
    set(INSTALL_TYPE copy)
else()
    set(INSTALL_TYPE create_symlink)
endif()

# don't reinstall if there is only 1 tagged file there, it's name matches, and it's newer than the source file
if(NOT EXISTING_TAGGED_FILES STREQUAL TAGGED_DEST_FILE OR ${SRC_FILE} IS_NEWER_THAN ${TAGGED_DEST_FILE})

    if (EXISTING_TAGGED_FILES)
        execute_process(
            COMMAND
                ${CMAKE_COMMAND} -E remove ${EXISTING_TAGGED_FILES}
            )
    endif()

    message(STATUS "installing ${TAGGED_DEST_FILE}")

    execute_process(
        COMMAND
            ${CMAKE_COMMAND} -E make_directory ${INSTALL_DIR}

        COMMAND
            ${CMAKE_COMMAND} -E ${INSTALL_TYPE} ${SRC_FILE} ${TAGGED_DEST_FILE}

        COMMAND
            ${CMAKE_COMMAND} -E touch ${TAGGED_DEST_FILE} # update the timestamp so subsequent installs aren't repeated unnecessarily
      )
endif()
