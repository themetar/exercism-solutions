#!/usr/bin/env bash

if [[ $1 = total ]]; then
    printf %u $(( 2 ** 64 - 1 ))
elif (( 1 <= $1 )) && (( $1 <= 64 )); then
    printf %u $(( 2 ** ($1 - 1) ))
else
    echo "Error: invalid input" >&2
    exit 1
fi