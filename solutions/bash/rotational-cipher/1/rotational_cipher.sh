#!/usr/bin/env bash

lows="abcdefghijklmnopqrstuvwxyz"
ups="ABCDEFGHIJKLMNOPQRSTUVWXYZ"

find_index() {
# params: string char
# Finds index of char in string
  local index=-1
  for ((i = 0; i < ${#1}; i++)); do
    if [[ ${1:$i:1} = "$2" ]]; then
      index=$i
    fi
  done
  echo "$index"
}

out=""

for ((i = 0; i < ${#1}; i++)); do
  if [[ index=$(find_index $lows ${1:i:1}) -ne -1 ]]; then
    ((index = (index + $2) % 26))
    out="$out${lows:index:1}"
  elif [[ index=$(find_index $ups ${1:i:1}) -ne -1 ]]; then
    ((index = (index + $2) % 26))
    out="$out${ups:index:1}"
  else
    out="$out${1:i:1}"
  fi
done

echo "$out"