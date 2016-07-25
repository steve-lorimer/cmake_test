#!/bin/bash

readonly TOP=$1; shift

readonly TEMP_DIR=$(mktemp -dt "$(basename $0.XXXXXXXXXX)")
trap "rm -rf ${TEMP_DIR}" EXIT

readonly VERSION=$(git describe --always --dirty --long --tags)
readonly NUM_COMMITS=$(git rev-list HEAD | wc -l | bc)
readonly BRANCH=$(git rev-parse --abbrev-ref HEAD)
readonly AHEAD_BY=$(git log --oneline origin/${BRANCH}..${BRANCH} | wc -l | bc)
readonly NUM_UNTRACKED=$(git ls-files --exclude-standard --others --full-name -- ${TOP} | wc -l | bc)
readonly HOSTNAME=$(hostname)

write_version_file()
{
    local filename=${1}

    cat <<- EOF > ${filename}
    #pragma once

    /*
    * Version information
    *
    * - This is a generated file - do not edit
    */

    #ifndef NDEBUG
    #  define _BUILD_VARIANT "debug"
    #else
    #  define _BUILD_VARIANT "release"
    #endif

    static const char VERSION[]       = "${VERSION}";
    static const char NUM_COMMITS[]   = "${NUM_COMMITS}";
    static const char BRANCH[]        = "${BRANCH}";
    static const char AHEAD_BY[]      = "${AHEAD_BY}";
    static const char NUM_UNTRACKED[] = "${NUM_UNTRACKED}";
    static const char USER[]          = "${USER}";
    static const char HOSTNAME[]      = "${HOSTNAME}";
    static const char BUILD_VARIANT[] = _BUILD_VARIANT;
    static const char BUILD_DATE[]    = __DATE__ " "  __TIME__;
    EOF
}

copy_if_different()
{
    local src_file=$1
    local dst_file=$2

    if [ -f ${dst_file} ]; then

        # diff the files
        diff ${src_file} ${dst_file} > /dev/null

        # if there are differences
        if [ $? -eq 0  ]; then
            return
        fi
    fi
    echo "branch=${BRANCH} commits=${NUM_COMMITS} ahead_by=${AHEAD_BY} num_untracked=${NUM_UNTRACKED} version=${VERSION}"
    mv ${src_file} ${dst_file}
}

main()
{
    local dst_file=${TOP}/app/version_details.h
    local src_file=${TEMP_DIR}/version

    write_version_file ${src_file}
    copy_if_different ${src_file} ${dst_file}
}
main "$@"

