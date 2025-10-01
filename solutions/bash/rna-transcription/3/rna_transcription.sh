#!/usr/bin/env bash

declare -A translation=( [G]=C [C]=G [T]=A [A]=U )

for ((len = ${#1}, idx = 0; idx < len; ++idx)); do
  protein=${1:idx:1}
  if [[ -z ${translation[$protein]} ]]; then
    echo "Invalid nucleotide detected." >&2 
    exit 1
  fi
  out+=${translation[$protein]}
done

echo "$out"
