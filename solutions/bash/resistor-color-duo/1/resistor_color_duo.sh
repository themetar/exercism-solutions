#!/usr/bin/env bash

declare -A colors
colors=( [black]=0 [brown]=1 [red]=2 [orange]=3 [yellow]=4 [green]=5 [blue]=6 [violet]=7 [grey]=8 [white]=9 )

value1="${colors[$1]}"
value2="${colors[$2]}"

if [[ -z $value1 || -z $value2 ]]; then
    echo "invalid color" >&2
    exit 1
fi

echo "$(( value1 * 10 + value2 ))"
