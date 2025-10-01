#!/usr/bin/env bash

shopt -s nocasematch

input="${1//[^a-z\']/ }"         # replace any non-word character with <space>

read -r -a words <<< "$input"    # read array of words

for word in "${words[@]}"; do
    acronym+="${word:0:1}"       # collect first letter of each word
done

echo "${acronym^^}"              # upcase and output