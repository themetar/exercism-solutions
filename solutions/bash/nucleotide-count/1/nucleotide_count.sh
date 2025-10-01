#!/usr/bin/env bash

declare -A count=( [A]=0 [C]=0 [G]=0 [T]=0 )

for (( len = ${#1}, i = 0; i < len; ++i )); do
    char=${1:i:1}
    case $char in
        [ACGT] ) (( count[$char]+= 1 )) ;;
        * )
            echo "Invalid nucleotide in strand" >&2
            exit 1
        ;;
    esac
done

for nuc in A C G T; do
    echo "$nuc: ${count[$nuc]}"
done
