#!/bin/bash

find_local_files()
{
    local dir=$1
    local files=$(find ${dir} -maxdepth 1 -type f -exec file {} \; | egrep ELF\|gzip | cut -f1 -d:)
        
    echo ${files}
}

short_tagged_regexp()
{
    local filename=$1
    local regexp=${filename}.*[0-9]+\(\.dirty\)\{0,1\}\(\.gz\)\{0,1\}$
    echo ${regexp}
}

long_tagged_regexp()
{
    local filename=$1
    local regexp=${filename}.*[0-9]+.g.*\(\.dirty\)\{0,1\}\(\.gz\)\{0,1\}$
    echo ${regexp}
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
    local type=$2
    
    local dir=$(dirname ${path})
    local filename=$(basename ${path})
        
    if [ "${type}" == "short" ]; then
        local regexp=$(short_tagged_regexp ${filename})
    elif [ "${type}" == "long" ]; then
        local regexp=$(long_tagged_regexp ${filename})
    else
        echo "invalid tag type ${type} specified"
        exit 1
    fi
    
    local found=$(find_tagged_file ${dir} ${regexp})
    
    if [ "${found}" != "" ]; then
         rm ${found}
    fi
}

remove_tagged_files "$@"
