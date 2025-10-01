#!/usr/bin/env bash

alphabet=abcdefghijklmnopqrstuvwxyz

alpha_index() {
# params: char
# Finds index of char in $alphabet
  local upto_alphabet=${alphabet/[$1]*}
  echo ${#upto_alphabet}
}

out=""

for ((len = ${#1}, idx = 0; idx < len; ++idx)); do
  char=${1:idx:1}
  lowcase=${char,}
  index=$(alpha_index "$lowcase")
  if [[ $index -lt 26 ]]; then
      rep=${alphabet:(index + $2) % 26:1}
      if [[ $char != $lowcase ]]; then rep=${rep^}; fi
      char=$rep
  fi
  out+=$char
done

echo "$out"
