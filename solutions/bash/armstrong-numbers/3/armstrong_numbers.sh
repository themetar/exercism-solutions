#!/usr/bin/env bash

for (( idx = 0, len = ${#1}; idx < len; ++idx )); do
    (( sum += ${1:idx:1} ** len ))
done

(( sum == $1 )) && echo true || echo false
