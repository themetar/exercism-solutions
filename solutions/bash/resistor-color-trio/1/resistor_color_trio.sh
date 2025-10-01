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

declare -A magnitudes=( [kilo]=1000 [mega]=1000000 [giga]=1000000000 )

for prefix in giga mega kilo; do
    (( resistance < magnitudes[$prefix] )) && continue
    if (( resistance % magnitudes[$prefix] == 0 )); then
        printf '%d %sohms\n' $(( resistance / magnitudes[$prefix] )) $prefix
        exit 0
    fi
done

echo "$resistance ohms"
