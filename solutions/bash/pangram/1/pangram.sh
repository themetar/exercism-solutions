#!/usr/bin/env bash

phrase=${1,,}

for char in {a..z}; do
    if [[ "$phrase" != *$char* ]]; then
        echo false
        exit 0
    fi
done

echo true
