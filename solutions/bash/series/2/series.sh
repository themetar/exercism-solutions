#!/usr/bin/env bash

series=$1
length=$2

if [[ $length -eq 0 ]]; then
    echo "slice length cannot be zero"
    exit 1
fi

if [[ $length -lt 0 ]]; then
    echo "slice length cannot be negative"
    exit 1
fi


if [[ -z $series ]]; then
    echo "series cannot be empty"
    exit 1
fi

if [[ ${#series} -lt $length ]]; then
    echo "slice length cannot be greater than series length"
    exit 1
fi

output=""

limit=$((${#series} - length + 1))

for ((i = 0; i < limit; i++)); do
    if [[ -n $output ]]; then
        output="$output "
    fi

    output="$output${series:$i:$length}"
done

echo "$output"
