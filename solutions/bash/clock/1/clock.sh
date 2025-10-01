#!/usr/bin/env bash

raise_error() {
    echo "invalid arguments" >&2
    exit 1
}

# reject bad number of arguments
(( $# != 2 && $# != 4 )) && raise_error

# reject non-integer hours and minutes
[[ ! "$1" =~ ^-?[0-9]+$ ]] && raise_error
[[ ! "$2" =~ ^-?[0-9]+$ ]] && raise_error

# reduce time into minutes
minutes=$(( $1 * 60 + $2 ))

# optional delta
if (( $# == 4 )); then
    # reject bad operator
    [[ ! "$3" == [+-] ]] && raise_error
    # reject non-integer delta
    [[ ! "$4" =~ ^[0-9]+$ ]] && raise_error
    # do calculation
    (( minutes = minutes $3 $4 ))
fi

# normalize minutes into 0..(mins_in_day - 1)
mins_in_day=$(( 24 * 60 ))
(( minutes %= mins_in_day ))
(( minutes += mins_in_day ))    # deal with negative values
(( minutes %= mins_in_day ))    #

# split into hours and minutes
hours=$(( minutes / 60 ))
(( minutes -= hours * 60 ))

# output
printf "%02d:%02d\n" "$hours" "$minutes"
