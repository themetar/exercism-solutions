#!/usr/bin/env bash

declare -A count=( [A]=0 [C]=0 [G]=0 [T]=0 )

while IFS= read -r -n 1 char; do
    if [[ -z ${count[$char]} ]]; then
        echo "Invalid nucleotide in strand" >&2
        exit 1
    fi

    (( count[$char]+= 1 ))
done < <( printf "%s" "$1" )

for nuc in A C G T; do
    echo "$nuc: ${count[$nuc]}"
done
