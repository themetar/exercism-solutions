#!/usr/bin/env bash

# read arrays from input
IFS=", " read -a list_a <<< "${1:1:-1}"
IFS=", " read -a list_b <<< "${2:1:-1}"

# get lengths
a_len="${#list_a[@]}"
b_len="${#list_b[@]}"

# set target and reorder, if necessary, so that list_a is the shorter one 
if (( a_len == b_len )); then
    target=equal
elif (( a_len < b_len )); then
    target=sublist
else    # a_len is > than b_len
    target=superlist
    tmp=( "${list_a[@]}" )
    list_a=( "${list_b[@]}" )
    list_b=( "${tmp[@]}")
    tmp="$a_len"
    a_len="$b_len"
    b_len="$tmp"
fi

# starting from every offset
for (( offset = 0; offset <= b_len - a_len; ++offset )); do
    does_match=true
    # check for value (in)equality
    for (( j = 0; j < a_len; ++j )); do
        if [[ ${list_b[offset + j]} != "${list_a[j]}" ]]; then
            does_match=false
            break
        fi
    done
    # we've gone through whole list_a
    # if does_match hasn't been changed
    if $does_match; then
        # report target and exit
        echo "$target"
        exit 0
    fi
done

echo unequal
