#!/usr/bin/env bash

for (( i = 1, j = i + 1; i < $#; ++i, ++j )); do
    echo "For want of a ${!i} the ${!j} was lost."
done

if (( $# > 0 )); then echo "And all for the want of a $1."; fi
