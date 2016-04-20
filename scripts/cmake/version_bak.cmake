if(__included_version_bak)
    return()
endif()
set(__included_version_bak YES)

include(string)

# commit hash, with dirty status, tags
execute_process(
    OUTPUT_VARIABLE   VERSION
    COMMAND           git describe --always --dirty --long --tags
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    OUTPUT_STRIP_TRAILING_WHITESPACE
    )

# number of commits
execute_process(
    OUTPUT_VARIABLE   NUM_COMMITS
    COMMAND           git rev-list HEAD
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

# number of commits ahead of origin
execute_process(
    OUTPUT_VARIABLE   AHEAD_BY
    COMMAND           git log --oneline origin/${BRANCH}..${BRANCH}
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    OUTPUT_STRIP_TRAILING_WHITESPACE
    )

# number of untracked files
execute_process(
    OUTPUT_VARIABLE   NUM_UNTRACKED
    COMMAND           git ls-files --exclude-standard --others --full-name -- 
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    OUTPUT_STRIP_TRAILING_WHITESPACE
    )

# hostname
execute_process(
    OUTPUT_VARIABLE   HOSTNAME
    COMMAND           hostname
    OUTPUT_STRIP_TRAILING_WHITESPACE
    )

# user
set(USER $ENV{USER})

# build variant
string(TOLOWER ${CMAKE_BUILD_TYPE} BUILD_VARIANT)

word_count("${NUM_COMMITS}"   NUM_COMMITS)
word_count("${AHEAD_BY}"      AHEAD_BY)
word_count("${NUM_UNTRACKED}" NUM_UNTRACKED)

message(STATUS "branch=${BRANCH} commits=${NUM_COMMITS} ahead_by=${AHEAD_BY} num_untracked=${NUM_UNTRACKED} version=${VERSION}")

configure_file (
    "${PROJECT_SOURCE_DIR}/app/version_details.h.in"
    "${PROJECT_SOURCE_DIR}/app/version_details.h"
    )