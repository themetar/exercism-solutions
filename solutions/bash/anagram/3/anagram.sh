#!/usr/bin/env bash

word=${1,,}  # to lowercase
word_length=${#word}

read -r -a candidates <<< "$2"

for candidate in "${candidates[@]}"; do
  # do not consider candidate if it's shorter/longer than word
  [[ $word_length -ne ${#candidate} ]] && continue

  copy=${candidate,,} # lowercase copy of candidate

  # can't be anagram of itself
  [[ $word = "$copy" ]] && continue

  for ((index = 0; index < word_length; ++index)); do
    char=${word:index:1}
    copy=${copy/$char} # delete char
  done

  [[ -z "$copy" ]] && output+=" $candidate"
done

echo "${output:1}"
