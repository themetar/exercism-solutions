#!/usr/bin/env bash

declare -A colors=( [black]=0 [brown]=1 [red]=2 [orange]=3 [yellow]=4 [green]=5 [blue]=6 [violet]=7 [grey]=8 [white]=9 )

digit1="${colors[$1]}"
digit2="${colors[$2]}"
zeroes="${colors[$3]}"

if [[ -z $digit1 || -z $digit2 || -z $zeroes ]]; then
    echo "invalid color" >&2
    exit 1
fi

resistance=$(( (digit1 * 10 + digit2) * 10 ** zeroes ))

prefixes=( "" kilo mega giga )

exp=0

while (( resistance > 1000 && resistance % 1000 == 0 )); do
    (( exp += 1 ))
    (( resistance /= 1000 ))
done

echo "$resistance ${prefixes[$exp]}ohms"
