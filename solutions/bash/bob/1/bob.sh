#!/usr/bin/env bash

QUESTION=1
YELLING=2
SILENCE=4

if [[ $1 =~ \?[[:space:]]*$ ]]; then
    (( score |= $QUESTION ))
fi

if [[ $1 =~ [A-Z] ]] && ! [[ $1 =~ [a-z] ]]; then
    (( score |= $YELLING ))
fi

if [[ $1 =~ ^[[:space:]]*$ ]]; then
    (( score |= $SILENCE ))
fi

case $score in
    $YELLING) echo "Whoa, chill out!";;
    $QUESTION) echo "Sure.";;
    $((QUESTION + YELLING))) echo "Calm down, I know what I'm doing!";;
    $SILENCE) echo "Fine. Be that way!";;
    *) echo "Whatever.";;
esac