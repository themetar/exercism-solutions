#!/usr/bin/env bash

for (( idx = 0, len = ${#1}; idx < len; ++idx )); do
    reversed="${1:idx:1}$reversed"
done

echo "$reversed"
