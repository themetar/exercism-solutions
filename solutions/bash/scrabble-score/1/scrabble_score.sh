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

for (( idx = 0, len = ${#word}; idx < len; ++idx )); do
    char=${word:idx:1}
    for key in "${!points[@]}"; do
        if [[ $key == *${char}* ]]; then
            (( score += points[$key] ))
            break
        fi
    done
done

echo "$score"
