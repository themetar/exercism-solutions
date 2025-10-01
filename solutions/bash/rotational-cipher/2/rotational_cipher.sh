#!/usr/bin/env bash

alphabet=abcdefghijklmnopqrstuvwxyz

find_index() {
# params: string char
# Finds index of char in string
  local upto_alphabet=${1/[$2]*}
  echo ${#upto_alphabet}
}

out=""

for ((len = ${#1}, idx = 0; idx < len; ++idx)); do
  char=${1:idx:1}
  lowcase=${char,}
  index=$(find_index $alphabet $lowcase)
  if [[ $index -lt 26 ]]; then
      rep=${alphabet:(index + $2) % 26:1}
      if [[ $char != $lowcase ]]; then rep=${rep^}; fi
      out+=$rep
  else
    out+=$char
  fi
done

echo "$out"
