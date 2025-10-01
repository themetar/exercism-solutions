#!/usr/bin/env bash

declare -A points
points=(
    [aeioulnrst]=1
    [dg]=2
    [bcmp]=3
    [fhvwy]=4
    [k]=5
    [jx]=8
    [qz]=10
)

word=${1,,}

score=0

for key in "${!points[@]}"; do
    filtered=${word//[^$key]}
    (( score += ${#filtered} * points[$key] ))
done

echo "$score"
