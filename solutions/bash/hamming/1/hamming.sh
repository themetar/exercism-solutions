#!/usr/bin/env bash

if [[ $# -lt 2 ]]; then
    echo "Usage: hamming.sh <string1> <string2>" >&2
    exit 1
fi

if [[ ${#1} -ne ${#2} ]]; then
    echo "strands must be of equal length" >&2
    exit 1
fi

count=0

for (( len = ${#1}, i = 0; i < len; ++i )); do
    [[ "${1:i:1}" != "${2:i:1}" ]] && (( count += 1 ))
done

echo $count
