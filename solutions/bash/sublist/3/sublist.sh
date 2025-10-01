#!/usr/bin/env bash

check() {
    local -n shorter="$1"
    local short_len="$2"
    local -n longer="$3"
    local long_len="$4"
    local offset

    for (( offset = 0; offset <= long_len - short_len; ++offset )); do
        local does_match=true
        # check for value (in)equality
        for (( j = 0; j < short_len; ++j )); do
            if [[ ${longer[offset + j]} != "${shorter[j]}" ]]; then
                does_match=false
                break
            fi
        done
        # we've gone through whole shorter list
        # if does_match hasn't been changed (i.e. all characters matched)
        if $does_match; then
            # report target and exit
            echo "$5"
            exit 0
        fi
    done

    echo unequal
}

# read arrays from input
IFS=", " read -r -a list_a <<< "${1:1:-1}"
IFS=", " read -r -a list_b <<< "${2:1:-1}"

# get lengths
a_len="${#list_a[@]}"
b_len="${#list_b[@]}"

# call `check` with shorter, longer, target
# appropriately passing a or b by length
if (( a_len == b_len )); then
    check list_a "$a_len" list_b "$b_len" equal
elif (( a_len < b_len )); then
    check list_a "$a_len" list_b "$b_len" sublist
else    # a_len is > than b_len
    check list_b "$b_len" list_a "$a_len" superlist
fi
