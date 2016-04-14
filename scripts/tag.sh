#!/bin/bash

readonly commits=$(git rev-list HEAD | wc -l | bc)
readonly branch=$(git rev-parse --abbrev-ref HEAD)

if [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]]; then
    readonly dirty=".dirty"
fi

printf ${branch}.${commits}${dirty}
