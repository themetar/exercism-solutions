#!/usr/bin/env bash

word=${1,,}  # to lowercase
word_length=${#word}

for candidate in $2; do
  if [[ $word_length -ne ${#candidate} ]]; then
    # do not consider candidate if it's shorter/longer than word
    continue
  fi

  copy=${candidate,,} # lowercase copy of candidate

  if [[ $word = "$copy" ]]; then
    # can't be anagram of itself
    continue
  fi

  for ((index = 0; index < word_length; ++index)); do
    char=${word:index:1}
    copy=${copy/$char} # delete char
  done

  if [[ -z "$copy" ]]; then
    output+=" $candidate"
  fi
done

echo "${output:1}"
