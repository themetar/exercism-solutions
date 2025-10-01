#!/usr/bin/env bash

for (( idx = ${#1} - 1; idx >= 0; --idx )); do
    reversed+="${1:idx:1}"
done

echo "$reversed"
