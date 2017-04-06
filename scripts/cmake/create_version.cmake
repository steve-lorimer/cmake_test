include(message)

if(NOT CMAKE_SCRIPTS_DIR)
    message(FATAL_ERROR "no cmake scripts dir specified")
endif()
if(NOT CMAKE_BUILD_TYPE)
    message(FATAL_ERROR "no build type specified")
endif()
if(NOT PURPOSE)
    message(FATAL_ERROR "no purpose specified")
endif()
if(NOT DEST_FILE)
    message(FATAL_ERROR "no destination file specified")
endif()

if(WIN32)
    set(COUNT_LINES find /c /v "")
else()
    set(COUNT_LINES wc -l)
endif()

if (CMAKE_BUILD_TYPE STREQUAL "Debug")

    set(VERSION       "skipped due to debug build")
    set(NUM_COMMITS   "skipped due to debug build")
    set(BRANCH        "skipped due to debug build")
    set(AHEAD_BY      "skipped due to debug build")
    set(NUM_UNTRACKED "skipped due to debug build")
    set(USER          "skipped due to debug build")
    set(HOSTNAME      "skipped due to debug build")

else()

  # git version
  execute_process(
      OUTPUT_VARIABLE VERSION
      COMMAND         git rev-parse --short HEAD
      WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
      OUTPUT_STRIP_TRAILING_WHITESPACE
      )

  # number of commits
  execute_process(
      OUTPUT_VARIABLE NUM_COMMITS
      COMMAND         git rev-list HEAD
      COMMAND         ${COUNT_LINES}
      WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
      OUTPUT_STRIP_TRAILING_WHITESPACE
      )

  # branch
    execute_process(
      OUTPUT_VARIABLE BRANCH
      COMMAND         git rev-parse --abbrev-ref HEAD
      WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
      OUTPUT_STRIP_TRAILING_WHITESPACE
      )

  # ahead by
  execute_process(
      OUTPUT_VARIABLE AHEAD_BY
      COMMAND         git log --oneline origin/${BRANCH}..${BRANCH}
      COMMAND         ${COUNT_LINES}
      WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
      OUTPUT_STRIP_TRAILING_WHITESPACE
      )

  # num untracked
  execute_process(
      OUTPUT_VARIABLE NUM_UNTRACKED
      COMMAND         git ls-files --exclude-standard --others --full-name -- .
      COMMAND         ${COUNT_LINES}
      WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
      OUTPUT_STRIP_TRAILING_WHITESPACE
      )

  # user
  execute_process(
      OUTPUT_VARIABLE USER
      COMMAND         whoami
      OUTPUT_STRIP_TRAILING_WHITESPACE
      )

  # hostname
  execute_process(
      OUTPUT_VARIABLE HOSTNAME
      COMMAND         hostname
      OUTPUT_STRIP_TRAILING_WHITESPACE
      )
endif()

# build variant
string(TOLOWER ${CMAKE_BUILD_TYPE} BUILD_VARIANT)

# get filename component for include file
get_filename_component(FILENAME ${DEST_FILE} NAME_WE)

set(TMP_OUTPUT_FILE ${CMAKE_BINARY_DIR}/version.cc.tmp)

# create temporary version file
configure_file(
    ${CMAKE_SCRIPTS_DIR}/version.cc.in
    ${TMP_OUTPUT_FILE}
    )

# compare with the real version file
execute_process(
    COMMAND
        ${CMAKE_COMMAND} -E compare_files
            ${TMP_OUTPUT_FILE}
            ${DEST_FILE}
    RESULT_VARIABLE
        VERSION_NEEDS_UPDATING

    OUTPUT_QUIET
    ERROR_QUIET
)

# update the real version file if necessary
if(VERSION_NEEDS_UPDATING)
    execute_process(
        COMMAND
            ${CMAKE_COMMAND} -E copy
                ${TMP_OUTPUT_FILE}
                ${DEST_FILE}
    )
    set(UPDATED "(updated)")
endif()

message(STATUS "${PURPOSE}: branch=${BRANCH} version=${VERSION} commits=${NUM_COMMITS} ahead_by=${AHEAD_BY} untracked=${NUM_UNTRACKED} variant=${BUILD_VARIANT} ${UPDATED}")
