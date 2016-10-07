#!/bin/bash

current_tag()
{
    local build_variant=$1

    local branch=$(git rev-parse --abbrev-ref HEAD)
    local commits=$(git rev-list HEAD | wc -l | bc)

    if [ "${branch}" != "master" ]; then
        local branch_tag="${branch}."
    fi

    if [ "${build_variant}" != "release" ]; then
        local build_tag=".${build_variant}"
    fi

    if [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]]; then
        local dirty_tag=".dirty"
    fi

    printf ${branch_tag}${commits}${build_tag}${dirty_tag}
}

main()
{
    local build_variant=$1
    local tag=$(current_tag ${build_variant})

    echo ${tag}
}

main "$@"
