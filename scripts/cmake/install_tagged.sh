#!/bin/bash

find_local_files()
{
    local dir=$1
    local files=$(find ${dir} -maxdepth 1 -type l)
        
    echo ${files}
}

find_tagged_file()
{
    local dir=$1
    local regexp=$2
    
    local files=$(find_local_files ${dir})
    
    for file in ${files}; do
        local found="${found} $(echo ${file} | egrep ${regexp})"
    done
    
    echo ${found}
}

remove_tagged_files()
{
    local path=$1
    
    local dir=$(dirname ${path})
    local filename=$(basename ${path})
       
    local regexp=${filename}.*[0-9]+\(\.dirty\)\{0,1\}\(\.gz\)\{0,1\}$
    
    local found=$(find_tagged_file ${dir} ${regexp})
    
    if [ "${found}" != "" ]; then
         rm ${found}
    fi
}

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

install_file()
{
    local source_file=$1
    local dest_file=$2
    local build_variant=$3

    local tag=$(current_tag ${build_variant})

    cp ${source_file} ${dest_file}.${tag}
}

main()
{
    local source_file=$1
    local dest_dir=$2
    local build_variant=$3

    remove_tagged_files ${dest_dir}
    install_file ${source_file} ${dest_dir} ${build_variant}
}

main "$@"
