#!/usr/bin/env bash

if (( $# < 2 )); then
    echo "not enough arguments"
    exit 1
fi

for i in {1..2}; do
    if ! [[ "${!i}" =~ ^-?[[:digit:]]+\.?[[:digit:]]*$ ]]; then
        echo "invalid arguments"
        exit 2
    fi
done

x=$1
y=$2

dist=$(echo "scale=3; sqrt($x^2 + $y^2)" | bc)

if [[ $(echo "scale=3; $dist <= 1 " | bc) -eq 1 ]]; then
  echo 10
elif [[ $(echo "scale=3; $dist <= 5 " | bc) -eq 1 ]]; then
  echo 5
elif [[ $(echo "scale=3; $dist <= 10 " | bc) -eq 1 ]]; then
  echo 1
else
  echo 0
fi
