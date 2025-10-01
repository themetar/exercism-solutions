#!/usr/bin/env bash

row_pattern="%-30s | %2s | %2s | %2s | %2s | %2s\n"

declare -A opposite=( [win]=loss [loss]=win [draw]=draw )
declare -A outcome_points=( [win]=3 [loss]=0 [draw]=1 )

IFS=";"

read_into() {
    local home_team guest_team outcome
    local -n array_var

    array_var="$1"

    while read -r home_team guest_team outcome; do
        [[ -z "$home_team" ]] && break

        array_var+=( "$home_team;$outcome" )
        array_var+=( "$guest_team;${opposite[$outcome]}" )
    done
}

tally() {
    local -a pair
    local played win draw loss points
    local -n input
    local -n output
    local -A temp

    input="$1"
    output="$2"

    for line in "${input[@]}"; do
        pair=( $line )

        local team="${pair[0]}"
        local outcome="${pair[1]}"

        [[ -z "${temp["$team"]}" ]] && temp["$team"]="0;0;0;0;0"

        local -a stats=( ${temp["$team"]} )

        local played="${stats[0]}"
        local win="${stats[1]}"
        local draw="${stats[2]}"
        local loss="${stats[3]}"
        local points="${stats[4]}"

        (( played += 1 ))
        (( ${outcome} += 1 ))
        (( points += outcome_points[$outcome] ))

        temp[$team]="$played;$win;$draw;$loss;$points"
    done

    for team in "${!temp[@]}"; do
        output+=( "$team;${temp[$team]}" )
    done
}

are_ordered() {
    local -a a=( $1 )
    local -a b=( $2 )

    (( a[5] > b[5] )) || { (( a[5] == b[5] )) && [[ ${a[0]} < ${b[0]} ]]; }
}

swap() {
    local -n array
    local i j
    array="$1"
    i="$2"
    j="$3"

    local tmp
    tmp="${array[i]}"
    array[i]="${array[j]}"
    array[j]="$tmp"
}


sort_points_name() {
    local -n array
    local start stop

    array="$1"

    [[ -v 2 ]] && start="$2" || start=0
    [[ -v 3 ]] && stop="$3" || stop="$(( ${#array[@]} - 1 ))"

    (( start >= stop )) && return

    local i j pivot
    i="$start"
    j="$stop"

    if (( j - i == 1 )); then
        are_ordered "${array[i]}" "${array[j]}" || swap "$1" "$i" "$j"
        return
    fi

    pivot=${array[(start + stop) / 2]}

    while (( i < j )); do
        while are_ordered "${array[i]}" "$pivot"; do
            (( ++i ))
        done

        while are_ordered "$pivot" "${array[j]}"; do
            (( --j ))
        done

        if (( i < j )); then
            swap "$1" "$i" "$j"
            (( ++i ))
            (( --j ))
        fi
    done

    sort_points_name "$1" "$start" "$j"
    sort_points_name "$1" "$i" "$stop"
}

print_out() {
    local -n array

    array="$1"

    for row in "${array[@]}"; do
        printf "$row_pattern" $row
    done
}

printf "$row_pattern" Team MP W D L P

declare -a pairs

if [[ -f "$1" ]]; then
    read_into pairs < "$1"
else
    read_into pairs
fi

declare -a tallied

tally pairs tallied

sort_points_name tallied

print_out tallied
