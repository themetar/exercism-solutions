#!/usr/bin/env bash

readonly question=1
readonly yelling=2
readonly silence=4

if [[ $1 =~ \?[[:space:]]*$ ]]; then
    (( score |= question ))
fi

if [[ $1 =~ [A-Z] ]] && ! [[ $1 =~ [a-z] ]]; then
    (( score |= yelling ))
fi

if [[ $1 =~ ^[[:space:]]*$ ]]; then
    (( score |= silence ))
fi

case $score in
    "$yelling") echo "Whoa, chill out!";;
    "$question") echo "Sure.";;
    $((question | yelling))) echo "Calm down, I know what I'm doing!";;
    "$silence") echo "Fine. Be that way!";;
    *) echo "Whatever.";;
esac